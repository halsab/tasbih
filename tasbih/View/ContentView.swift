//
//  ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 19.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var countManager = CountManager()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        CountView()
            .environmentObject(countManager)
            .onChange(of: scenePhase) { newValue in
                if newValue == .background {
                    countManager.saveAll()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
