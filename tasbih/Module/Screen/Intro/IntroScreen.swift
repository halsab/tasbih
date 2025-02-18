//
//  IntroScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 16.02.2025.
//

import SwiftUI

struct IntroScreen: View {
    @State private var activeCard: IntroCard? = .cards.first
    @State private var scrollPosition: ScrollPosition = .init()
    @State private var currentScrollOffset: CGFloat = 0
    @State private var timer = Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()
    @State private var initialAnimation = false
    @State private var scrollPhase: ScrollPhase = .idle
    
    var body: some View {
        ZStack {
            AmbientBG()
                .animation(.easeInOut(duration: 1), value: activeCard)
            
            VStack(spacing: 40) {
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

                VStack(spacing: 4) {
                    Text("السلام عليكم")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.secondary)
                        .blurOpacityEffect(initialAnimation)
                    
                    Text("Tasbih App")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .blurOpacityEffect(initialAnimation)
                        .padding(.bottom, 12)
                    
                    Text("Пусть это приложение станет вашим верным спутником в стремлении укрепить связь со Всевышним, ведь зикр – это свет для сердца и души каждого мусульманина.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.secondary)
                        .blurOpacityEffect(initialAnimation)
                }
                
                Button {
                    timer.upstream.connect().cancel()
                } label: {
                    Text("Создать зикр")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 12)
                        .background(.white, in: .capsule)
                }
                .blurOpacityEffect(initialAnimation)
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
                        .font(.system(size: 54, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            Color.black.blur(radius: 60, opaque: false)
                        }
                    
                    Spacer()
                    Text(card.description)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.secondary)
                        .padding()
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
    IntroScreen()
}

extension View {
    func blurOpacityEffect(_ show: Bool) -> some View {
        self
            .blur(radius: show ? 0 : 2)
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.9)
    }
}
