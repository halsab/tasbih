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
    @State private var isTranslationVisible = false
    @State private var isTranscriptionVisible = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if isArabicVisible {
                    SentencesView(
                        sentances: dua.sentences.map(\.arabic),
                        firstSentenceNumber: dua.firstSentenceNumber,
                        lineSpacing: 8,
                        textFont: .system(.largeTitle, design: .rounded, weight: .light),
                        dotFont: .system(.title2, design: .rounded, weight: .bold),
                        alignment: .trailing
                    )
                }
                
                if isTranslationVisible {
                    SentencesView(
                        sentances: dua.sentences.map(\.translation),
                        firstSentenceNumber: dua.firstSentenceNumber,
                        lineSpacing: 4,
                        textFont: .system(.title3, design: .rounded, weight: .light),
                        dotFont: .system(.body, design: .rounded, weight: .bold),
                        alignment: .leading
                    )
                }
                
                if isTranscriptionVisible {
                    SentencesView(
                        sentances: dua.sentences.map(\.transcription),
                        firstSentenceNumber: dua.firstSentenceNumber,
                        lineSpacing: 4,
                        textFont: .system(.title3, design: .rounded, weight: .light),
                        dotFont: .system(.body, design: .rounded, weight: .bold),
                        alignment: .leading
                    )
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(dua.name.translation)
                        Text(dua.sentencesRange)
                    }
                    .font(.app.mTitle)
                    .foregroundStyle(Color.secondary)
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Toggle("Arabic", isOn: $isArabicVisible)
                            .toggleStyle(CheckToggleStyle())
                        Toggle("Translation", isOn: $isTranslationVisible)
                            .toggleStyle(CheckToggleStyle())
                        Toggle("Transcription", isOn: $isTranscriptionVisible)
                            .toggleStyle(CheckToggleStyle())
                    }
                }
            }
        }
    }
}

#Preview {
    DuaView(dua: _1_Fatiha)
}

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.isOn ? Image.app.selection.on : Image.app.selection.off
                configuration.label
            }
            .font(.app.mBody)
            .foregroundStyle(Color.secondary)
        }
        .buttonStyle(.plain)
    }
}
