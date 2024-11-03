//
//  SentencesView.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 03.11.2024.
//

import SwiftUI

struct SentencesView: View {
    
    let sentances: [String]
    let firstSentenceNumber: Int
    let lineSpacing: CGFloat
    let textFont: Font
    let dotFont: Font
    let alignment: TextAlignment
    
    var body: some View {
        sentances
            .enumerated()
            .reduce(Text("")) { text, sentence in
                text
                + Text(sentence.element)
                    .font(textFont)
                    .foregroundStyle(Color.system.gray)
                + Text(" -\(sentence.offset + firstSentenceNumber)- ")
                    .font(dotFont)
                    .foregroundStyle(Color.app.tint)
            }
            .multilineTextAlignment(alignment)
            .lineSpacing(lineSpacing)
    }
}

#Preview {
    SentencesView(
        sentances: [],
        firstSentenceNumber: 1,
        lineSpacing: 0,
        textFont: .app.lTitle,
        dotFont: .app.mBody,
        alignment: .leading
    )
}
