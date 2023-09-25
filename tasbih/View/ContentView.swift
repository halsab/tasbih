//
//  ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 19.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var countManager = CountManager()
    
    var body: some View {
        CountView()
            .environmentObject(countManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
