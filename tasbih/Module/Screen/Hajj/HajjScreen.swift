//
//  HajjScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 23.09.2025.
//

import SwiftUI

struct HajjScreen: View {
    var body: some View {
        VStack {
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: HajjMapScreen()) {
                    Image(systemName: "map")
                }
            }
        }
    }
}

#Preview {
    HajjScreen()
}
