//
//  HadjScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 23.09.2025.
//

import SwiftUI

struct HadjScreen: View {
    var body: some View {
        VStack {
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: HadjMapScreen()) {
                    Image(systemName: "map")
                }
            }
        }
    }
}

#Preview {
    HadjScreen()
}
