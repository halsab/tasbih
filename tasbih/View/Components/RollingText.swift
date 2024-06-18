//
//  RollingText.swift
//  tasbih
//
//  Created by Khalil Sabirov on 10.11.2023.
//

import SwiftUI

struct RollingText: View {
    
    @Binding var value: Int
    let font: Font
    let foregroundColor: Color

    @State private var animationRange: [Int] = []

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { index in
                Text("0")
                    .foregroundStyle(foregroundColor)
                    .font(font)
                    .monospacedDigit()
                    .opacity(0)
                    .overlay {
                        GeometryReader { proxy in
                            let size = proxy.size

                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { number in
                                    Text("\(number)")
                                        .foregroundStyle(foregroundColor)
                                        .font(font)
                                        .monospacedDigit()
                                        .frame(width: size.width, height: size.height, alignment: .center)

                                }
                            }
                            .offset(y: -CGFloat(animationRange[index]) * size.height)
                        }
                        .clipped()
                    }
            }
        }
        .onAppear {
            animationRange = Array(repeating: 0, count: "\(value)".count)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
                updateText()
            }
        }
        .onChange(of: value) { _, _ in
            let extra = "\(value)".count - animationRange.count
            for _ in 0..<extra {
                withAnimation(.easeIn(duration: 0.1)) {
                    animationRange.append(0)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
                updateText()
            }
        }
    }

    private func updateText() {
        let stringValue = "\(value)"
        for (index, value) in zip(0..<stringValue.count, stringValue) {
            var fraction = Double(index) * 0.15
            fraction = fraction > 0.5 ? 0.5 : fraction
            withAnimation(.interactiveSpring(
                response: 0.8,
                dampingFraction: 1 + fraction,
                blendDuration: 1 + fraction)
            ) {
                animationRange[index] = (String(value) as NSString).integerValue
            }
        }
    }
}

#Preview {
    RollingText(value: .constant(123), font: .body, foregroundColor: .red)
        .preferredColorScheme(.dark)
}
