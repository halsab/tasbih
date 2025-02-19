//
//  IntroScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 16.02.2025.
//

import SwiftUI

struct IntroScreen: View {
    @Bindable var countService: CountService
    
    @State private var activeCard: IntroCard? = .cards.first
    @State private var scrollPosition: ScrollPosition = .init()
    @State private var currentScrollOffset: CGFloat = 0
    @State private var timer = Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()
    @State private var initialAnimation = false
    @State private var scrollPhase: ScrollPhase = .idle
    @State private var showFirstZikrCreationAlert = false
    @State private var firstZikrName = ""
    
    var body: some View {
        ZStack {
            AmbientBG()
                .animation(.easeInOut(duration: 1), value: activeCard)
            
            VStack(spacing: 40) {
                CarouselCardsView()

                TextSection()
                
                ActionView {
                    showFirstZikrCreationAlert.toggle()
                }
            }
            .safeAreaPadding(15)
        }
        .onReceive(timer) { _ in
            currentScrollOffset += 0.35
            scrollPosition.scrollTo(x: currentScrollOffset)
        }
        .task {
            try? await Task.sleep(for: .seconds(0.35))
            
            withAnimation(.smooth(duration: 0.75, extraBounce: 0)) {
                initialAnimation = true
            }
        }
        .alert(String.text.alert.createFirstZikr, isPresented: $showFirstZikrCreationAlert) {
            ZikrCreationAlertView(name: $firstZikrName, isValid: {
                countService.isNewZikrNameValid(firstZikrName)
            }, action: {
                timer.upstream.connect().cancel()
                countService.createZikr(name: firstZikrName)
            })
        }
    }
    
    @ViewBuilder
    private func ActionView(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(String.text.intro.startButtonTitle)
                .font(.app.font(.m).weight(.semibold))
                .foregroundStyle(.black)
                .padding(.horizontal, 25)
                .padding(.vertical, 12)
                .background(.white, in: .capsule)
        }
        .blurOpacityEffect(initialAnimation)
    }
    
    @ViewBuilder
    private func TextSection() -> some View {
        VStack(spacing: 4) {
            Text(String.text.intro.welcome)
                .font(.app.font(.l))
                .foregroundStyle(.white.secondary)
                .blurOpacityEffect(initialAnimation)
            
            Text(String.text.intro.appName)
                .font(.app.font(.xxl).bold())
                .foregroundStyle(.white)
                .blurOpacityEffect(initialAnimation)
                .padding(.bottom, 12)
            
            Text(String.text.intro.description)
                .font(.app.font(.m))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .foregroundStyle(.white.secondary)
                .blurOpacityEffect(initialAnimation)
        }
    }
    
    @ViewBuilder
    private func CarouselCardsView() -> some View {
        InfiniteScrollView {
            ForEach(IntroCard.cards) { card in
                CarouselCardView(card)
            }
        }
        .scrollIndicators(.hidden)
        .scrollPosition($scrollPosition)
        .scrollClipDisabled()
        .containerRelativeFrame(.vertical) { value, _ in
            value * 0.45
        }
        .onScrollPhaseChange { oldPhase, newPhase in
            scrollPhase = newPhase
        }
        .onScrollGeometryChange(for: CGFloat.self) {
            $0.contentOffset.x + $0.contentInsets.leading
        } action: { oldValue, newValue in
            currentScrollOffset = newValue
            
            if scrollPhase != .decelerating || scrollPhase != .animating {
                let activeIndex = Int((currentScrollOffset / 220).rounded()) % IntroCard.cards.count
                activeCard = IntroCard.cards[activeIndex]
            }
        }
        .visualEffect { [initialAnimation] content, proxy in
            content
                .offset(y: !initialAnimation ? -(proxy.size.height + 200) : 0)
        }
    }
    
    @ViewBuilder
    private func AmbientBG() -> some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                ForEach(IntroCard.cards) { card in
                    Image(card.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .ignoresSafeArea()
                        .opacity(activeCard?.id == card.id ? 1 : 0)
                }
                
                Rectangle()
                    .fill(.black.opacity(0.4))
                    .ignoresSafeArea()
            }
            .compositingGroup()
            .blur(radius: 90, opaque: true)
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func CarouselCardView(_ card: IntroCard) -> some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(color: .black.opacity(0.4), radius: 10, x: 1, y: 0)
             
                VStack {
                    Spacer()
                    Text(card.title)
                        .font(.system(size: 54, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            Color.black.blur(radius: 60, opaque: false)
                        }
                    
                    Spacer()
                    Text(card.description)
                        .font(.app.font(.m))
                        .lineSpacing(6)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.secondary)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                }
                .frame(width: 220)
            }
            .frame(width: size.width, height: size.height)
            .clipShape(.rect(cornerRadius: 20))
        }
        .frame(width: 220)
        .scrollTransition(.interactive.threshold(.centered), axis: .horizontal) { content, phase in
            content
                .offset(y: phase == .identity ? -10 : 0)
                .rotationEffect(.degrees(phase.value * 5), anchor: .bottom)
        }
    }
}

#Preview {
    IntroScreen(countService: CountService(modelContext: ZikrModel.previewContainer.mainContext))
}

extension View {
    func blurOpacityEffect(_ show: Bool) -> some View {
        self
            .blur(radius: show ? 0 : 2)
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.9)
    }
}
