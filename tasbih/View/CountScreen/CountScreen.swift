//
//  CountScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.09.2023.
//

import SwiftUI

struct CountScreen: View {

    @StateObject var cm = CountManager()

    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                    .padding(.horizontal)
                    .padding(.top)

                CentralView()

                FooterView()
                    .padding(.horizontal)
            }
            
            if cm.isDesignMode {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .background(.ultraThinMaterial)

                    VStack {
                        HStack {
                            Spacer()

                            Button {
                                withAnimation {
                                    cm.isDesignMode.toggle()
                                }
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .font(.title)
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(Color.primary)

                            }
                            .padding(8)
                            .background(.red)
                            .clipShape(.rect(cornerRadius: 8))
                        }

                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .environmentObject(cm)
    }
}

#Preview {
    CountScreen()
        .environmentObject(CountManager())
        .preferredColorScheme(.dark)
}
