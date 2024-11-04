//
//  DuaHomeScreen.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 02.11.2024.
//

import SwiftUI
import HelperKit
import AppUIKit

public struct DuaHomeScreen: View {
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Sura")
                    .font(.app.font(.m, .bold))
                    .foregroundStyle(Color.app.highlight.gradient)
                ) {
                    ForEach(suras) { sura in
                        NavigationLink(value: sura) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(sura.name.translation)
                                        .foregroundStyle(Color.system.label)
                                    if !sura.isFull {
                                        Text(sura.sentencesRange)
                                            .foregroundStyle(Color.system.secondaryLabel)
                                    }
                                }
                                .font(.app.font(.m, .bold))
                                
                                if let alternativeName = sura.name.alternative {
                                    Text(alternativeName)
                                        .foregroundStyle(Color.system.tertiaryLabel)
                                        .font(.app.font(.xxs))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: DuaModel.self) { dua in
                DuaView(dua: dua)
            }
        }
    }
    
    @ViewBuilder
    private func qwe(sentences: [String]) -> some View {
        Group {
            sentences.enumerated().reduce(Text("")) { text, sentence in
                text
                + Text(sentence.element)
                + Text(" -\(sentence.offset + 1)- ")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundStyle(Color.app.tint)
            }
        }
        .font(.system(.largeTitle, design: .rounded, weight: .light))
        .foregroundStyle(Color.system.gray)
        .multilineTextAlignment(.trailing)
        .lineSpacing(8)
        .padding(8)
    }
}

#Preview {
    DuaHomeScreen()
        .tint(.app.tint)
}
