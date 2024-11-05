//
//  SentenceView.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 03.11.2024.
//

import SwiftUI

struct SentenceView: View {
    
    let duaName: String
    let sentence: DuaModel.Sentence
    
    @Binding var isArabicVisible: Bool
    @Binding var isTranslationVisible: Bool
    @Binding var isTranscriptionVisible: Bool
    
    @State private var showTafsir = false
    
    private let separatorColor: Color = .system.gray4
    
    var body: some View {
        VStack {
            HStack {
                Text("\(sentence.number)")
                    .font(.app.font(.s, .bold))
                    .foregroundStyle(Color.app.tint)
                
                if let _ = sentence.tafsir {
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundStyle(Color.app.highlight)
                }
                
                hSeparator(color: .app.tint)
            }
            
            if isArabicVisible {
                Text(sentence.arabic)
                    .font(.app.font(.xxl))
                    .foregroundStyle(Color.primary)
                    .multilineTextAlignment(.trailing)
                    .lineSpacing(8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                if isTranslationVisible || isTranscriptionVisible {
                    hSeparator()
                }
            }
            
            if isTranscriptionVisible {
                Text(sentence.transcription)
                    .font(.app.font(.m))
                    .foregroundStyle(Color.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if isTranslationVisible {
                    hSeparator()
                }
            }
            
            if isTranslationVisible {
                Text(sentence.translation)
                    .font(.app.font(.m))
                    .foregroundStyle(isArabicVisible || isTranscriptionVisible ? Color.secondary : Color.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(8)
        .background(.background.secondary)
        .clipShape(.rect(cornerRadius: 8))
        .onTapGesture {
            if let _ = sentence.tafsir {
                showTafsir.toggle()
            }
        }
        .sheet(isPresented: $showTafsir) {
            if let tafsir = sentence.tafsir {
                TafsirView(
                    duaName: duaName,
                    sentenceNumber: sentence.number,
                    tafsir: tafsir
                )
            }
        }
    }
    
    @ViewBuilder
    private func hSeparator(color: Color = .system.gray4) -> some View {
        color.frame(height: 1)
    }
}

#Preview {
    SentenceView(
        duaName: "Fatiha",
        sentence: _1_Fatiha.sentences.last!,
        isArabicVisible: .constant(true),
        isTranslationVisible: .constant(true),
        isTranscriptionVisible: .constant(true)
    )
    .padding()
}
