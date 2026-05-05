//
//  IntroScreen+InfiniteScrollView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 16.02.2025.
//

import SwiftUI

extension IntroScreen {
    struct InfiniteScrollView<Content: View>: View {
        var spacing: CGFloat = 10
        @ViewBuilder var content: Content
        @State private var contentSize: CGSize = .zero
        var body: some View {
            GeometryReader {
                let size = $0.size

                ScrollView(.horizontal) {
                    HStack(spacing: spacing) {
                        Group(subviews: content) { collection in
                            let views = Array(collection)

                            if !views.isEmpty {
                                HStack(spacing: spacing) {
                                    ForEach(views) { view in
                                        view
                                    }
                                }
                                .onGeometryChange(for: CGSize.self) {
                                    $0.size
                                } action: { newValue in
                                    contentSize = .init(width: newValue.width + spacing, height: newValue.height)
                                }

                                let averageWidth = contentSize.width / CGFloat(views.count)
                                let repeatingCount = if contentSize.width > 0 {
                                    max(Int((size.width / averageWidth).rounded()) + 1, views.count * 3)
                                } else {
                                    views.count
                                }

                                HStack(spacing: spacing) {
                                    ForEach(0..<repeatingCount, id: \.self) { index in
                                        let view = views[index % views.count]

                                        view
                                    }
                                }
                            }
                        }
                    }
                    .background(InfiniteScrollViewHelper(contentSize: $contentSize, declarationRate: .constant(.fast)))
                }
            }
        }
    }
}

fileprivate struct InfiniteScrollViewHelper: UIViewRepresentable {
    @Binding var contentSize: CGSize
    @Binding var declarationRate: UIScrollView.DecelerationRate

    func makeCoordinator() -> Coordinator {
        Coordinator(
            declarationRate: declarationRate,
            contentSize: contentSize
        )
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear

        DispatchQueue.main.async {
            if let scrollView = view.scrollView {
                context.coordinator.defaultDelegate = scrollView.delegate
                scrollView.decelerationRate = declarationRate
                scrollView.delegate = context.coordinator
            }
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.declarationRate = declarationRate
        context.coordinator.contentSize = contentSize
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var declarationRate: UIScrollView.DecelerationRate
        var contentSize: CGSize

        init(
            declarationRate: UIScrollView.DecelerationRate,
            contentSize: CGSize
        ) {
            self.declarationRate = declarationRate
            self.contentSize = contentSize
        }

        weak var defaultDelegate: UIScrollViewDelegate?

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            scrollView.decelerationRate = declarationRate
            recenterIfNeeded(scrollView)
            defaultDelegate?.scrollViewDidScroll?(scrollView)
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                recenterIfNeeded(scrollView, force: true)
            }

            defaultDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            recenterIfNeeded(scrollView, force: true)
            defaultDelegate?.scrollViewDidEndDecelerating?(scrollView)
        }

        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            defaultDelegate?.scrollViewWillBeginDragging?(scrollView)
        }

        func scrollViewWillEndDragging(
            _ scrollView: UIScrollView,
            withVelocity velocity: CGPoint,
            targetContentOffset: UnsafeMutablePointer<CGPoint>
        ) {
            defaultDelegate?.scrollViewWillEndDragging?(
                scrollView,
                withVelocity: velocity,
                targetContentOffset: targetContentOffset
            )
        }

        private func recenterIfNeeded(_ scrollView: UIScrollView, force: Bool = false) {
            guard contentSize.width > 0 else { return }

            // Во время быстрого жеста не дергаем contentOffset, иначе UIScrollView теряет плавность инерции.
            guard force || (!scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating) else { return }

            let minX = scrollView.contentOffset.x

            if minX > contentSize.width {
                scrollView.contentOffset.x -= contentSize.width
            }

            if minX < 0 {
                scrollView.contentOffset.x += contentSize.width
            }
        }
    }
}

extension UIView {
    var scrollView: UIScrollView? {
        if let superview, superview is UIScrollView {
            return superview as? UIScrollView
        }

        return superview?.scrollView
    }
}
