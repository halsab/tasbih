//
//  File.swift
//  AppUIKit
//
//  Created by Khalil Sabirov on 04.11.2024.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func hideNavBarOnSwipe(_ isHidden: Bool) -> some View {
        self.modifier(NavBarModifier(isHidden: isHidden))
    }
}

private struct NavBarModifier: ViewModifier {
    var isHidden: Bool
    func body(content: Content) -> some View {
        content
            .background(NavigationControllerExtractor(isHidden: isHidden))
    }
}

private struct NavigationControllerExtractor: UIViewRepresentable {
    
    var isHidden: Bool
    
    func makeUIView(context: Context) -> some UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if let hostView = uiView.superview?.superview,
               let parentController = hostView.parentController {
                parentController.navigationController?.hidesBarsOnSwipe = isHidden
            }
        }
    }
}

private extension UIView {
    var parentController: UIViewController? {
        sequence(first: self) { view in
            view.next
        }
        .first { responder in
            return responder is UIViewController
        } as? UIViewController
    }
}

struct Navigation_Extension: View {
    var body: some View {
        EmptyView()
    }
}
