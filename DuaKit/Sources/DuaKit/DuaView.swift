//
//  DuaView.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 03.11.2024.
//

import SwiftUI

struct DuaView: View {
    
    let dua: DuaModel
    
    @State private var isArabicVisible = true
    @State private var isTranslationVisible = true
    @State private var isTranscriptionVisible = false
    
    var body: some View {
        ScrollView {
            ForEach(dua.sentences) { sentence in
                SentenceView(
                    sentence: sentence,
                    isArabicVisible: $isArabicVisible,
                    isTranslationVisible: $isTranslationVisible,
                    isTranscriptionVisible: $isTranscriptionVisible
                )
            }
            .padding(8)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(dua.name.translation)
                        Text(dua.sentencesRange)
                    }
                    .font(.app.font(.m, .bold))
                    .foregroundStyle(Color.secondary)
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Toggle("arabic", isOn: $isArabicVisible)
                        Toggle("transcription", isOn: $isTranscriptionVisible)
                        Toggle("translation", isOn: $isTranslationVisible)
                    }
                    .toggleStyle(ButtonToggleStyle())
                }
            }
        }
    }
}

#Preview {
    DuaView(dua: _1_Fatiha)
}

struct ButtonToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isOn.toggle()
            }
        } label: {
            configuration.label
                .font(.app.font(.s))
                .foregroundStyle(Color.app.tint)
        }
        .padding(.vertical, 2)
        .padding(.horizontal, 4)
        .background(Color.app.tint.opacity(configuration.isOn ? 0.15 : 0))
        .clipShape(.capsule)
    }
}
