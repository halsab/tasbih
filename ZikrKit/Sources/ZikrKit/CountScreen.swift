//
//  CountScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.09.2023.
//

import SwiftUI
import SwiftData
import HelperKit

public struct CountScreen: View {

    @StateObject private var cm = CountManager()
    @Query private var zikrs: [ZikrModel]

    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            CentralView()
            
            FooterView()
        }
        .padding()
        .padding(.top)
        .environmentObject(cm)
        .ignoresSafeArea(edges: [.top])
    }
}

#Preview {
    CountScreen()
        .environmentObject(CountManager())
        .preferredColorScheme(.dark)
}
