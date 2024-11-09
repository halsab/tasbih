//
//  BookView.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 07.11.2024.
//

import SwiftUI

struct BookView: View {
    
    let imageNames: [String]
    
    @State private var isToolbarVisible = true
    
    var body: some View {
        TabView {
            ForEach(imageNames, id: \.self) { imageName in
                Tab {
                    Image.moduleImage(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
        }
        .tabViewStyle(.page)
        .background(Color.app.bg.sura)
        .onTapGesture {
            withAnimation {
                isToolbarVisible.toggle()
            }
        }
        .toolbar(isToolbarVisible ? .visible : .hidden, for: .navigationBar)
        .toolbar(isToolbarVisible ? .visible : .hidden, for: .tabBar)
    }
}

#Preview {
    BookView(imageNames: _1_Fatiha.imageNames)
}
