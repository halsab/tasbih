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
        }
        .environmentObject(cm)
    }
}

#Preview {
    CountScreen()
        .environmentObject(CountManager())
        .preferredColorScheme(.dark)
}
