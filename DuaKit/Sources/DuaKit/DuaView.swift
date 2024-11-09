//
//  DuaView.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 03.11.2024.
//

import SwiftUI
import AppUIKit

struct DuaView: View {
    
    let dua: DuaModel
    
    @State private var isArabicVisible = true
    @State private var isTranslationVisible = true
    @State private var isTranscriptionVisible = false
    
    var body: some View {
        ScrollView {
            ForEach(dua.sentences) { sentence in
                SentenceView(
                    duaName: dua.name.translation,
                    sentence: sentence,
                    isArabicVisible: $isArabicVisible,
                    isTranslationVisible: $isTranslationVisible,
                    isTranscriptionVisible: $isTranscriptionVisible
                )
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    if let alternativeName = dua.name.alternative {
                        Text(alternativeName)
                    } else {
                        Text(dua.name.translation)
                        if !dua.isFull {
                            Text(dua.sentencesRange)
                        }
                    }
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
                .toggleStyle(FilterToggleStyle())
            }
            
            if dua.isImagesExist {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(value: dua.imageNames) {
                        Image.app.button.book
                    }
                }
            }
        }
        .navigationDestination(for: [String].self) { imageNames in
            BookView(imageNames: imageNames)
        }
    }
}

#Preview {
    NavigationStack {
        DuaView(dua: _1_Fatiha)
    }
}
