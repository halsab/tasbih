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

#Preview(traits: .sizeThatFitsLayout) {
    SentencesView(
        sentances: [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
            "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        ],
        firstSentenceNumber: 1,
        lineSpacing: 0,
        textFont: .app.font(.xxxl, .bold),
        dotFont: .app.font(.m),
        alignment: .leading
    )
    .padding()
}
