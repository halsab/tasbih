//
//  ContentView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 19.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CountView()
            .tint(.base)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.light)
//            .preferredColorScheme(.dark)
    }
}
