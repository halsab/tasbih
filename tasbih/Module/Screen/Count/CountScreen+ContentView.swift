//
//  CountScreen+ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 09.02.2025.
//

import SwiftUI

extension CountScreen {
    struct ContentView: View {
        @Bindable var countService: CountService
        
        var body: some View {
            VStack {
                HeaderView(countService: countService)
                CentralView(countService: countService)
                FooterView(countService: countService)
            }
        }
    }
}
