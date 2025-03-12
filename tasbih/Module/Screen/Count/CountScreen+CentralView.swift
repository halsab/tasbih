//
//  CountScreen+CentralView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct CentralView: View {
        @Bindable var countService: CountService
        
        var body: some View {
            if let zikr = countService.selectedZikr {
                ZStack {
                    AnimationView(zikr: zikr)
                    
                    Image.app.button.count
                        .font(.system(size: 100))
                        .foregroundStyle(Color.shape(.app.tint.tertiary))
                        .symbolEffect(.bounce, options: .nonRepeating.speed(2), value: zikr.count)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    countService.increment(zikr: zikr)
                }
            } else {
                EmptyView()
            }
        }
        
        struct AnimationView: View {
            @Bindable var zikr: ZikrModel
            
            @State private var pulsedHearts: [HeartParticleModel] = []
            
            var body: some View {
                TimelineView(.animation(minimumInterval: 0.5, paused: false)) { _ in
                    Canvas { context, size in
                        handleCanvas(context: context, size: size)
                    } symbols: {
                        CanvasSymbols()
                    }
                }
                .onChange(of: zikr.count) {
                    addPulsedHeart()
                }
            }
            
            @ViewBuilder
            private func CanvasSymbols() -> some View {
                ForEach(pulsedHearts) {
                    PulsedHeartView()
                        .id($0.id)
                }
            }
            
            private func handleCanvas(context: GraphicsContext, size: CGSize) {
                pulsedHearts
                    .compactMap { context.resolveSymbol(id: $0.id) }
                    .forEach { context.draw($0, at: .init(x: size.width / 2, y: size.height / 2)) }
            }
            
            private func addPulsedHeart() {
                let pulsedHeart = HeartParticleModel()
                pulsedHearts.append(pulsedHeart)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    pulsedHearts.removeAll(where: { $0.id == pulsedHeart.id })
                }
            }
        }
    }
}
