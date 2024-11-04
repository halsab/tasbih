//
//  SentenceView.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 03.11.2024.
//

import SwiftUI

struct SentenceView: View {
    
    let sentence: DuaModel.Sentence
    
    @Binding var isArabicVisible: Bool
    @Binding var isTranslationVisible: Bool
    @Binding var isTranscriptionVisible: Bool
    
    private let separatorColor: Color = .system.gray4
    
    var body: some View {
        VStack {
            HStack {
                Text("\(sentence.number)")
                    .font(.app.font(.s, .bold))
                    .foregroundStyle(Color.app.tint)
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
    }
    
    @ViewBuilder
    private func hSeparator(color: Color = .system.gray4) -> some View {
        color.frame(height: 1)
    }
}

#Preview {
    SentenceView(
        sentence: _1_Fatiha.sentences.last!,
        isArabicVisible: .constant(true),
        isTranslationVisible: .constant(true),
        isTranscriptionVisible: .constant(true)
    )
    .padding()
}