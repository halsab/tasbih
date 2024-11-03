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
                    .font(.app.mTitle)
                    .foregroundStyle(Color.app.highlight.gradient)
                ) {
                    ForEach(suras) { sura in
                        NavigationLink(value: sura) {
                            HStack {
                                Text(sura.name.translation)
                                    .foregroundStyle(Color.primary)
                                Text(sura.sentencesRange)
                                    .foregroundStyle(Color.secondary)
                            }
                            .font(.app.mTitle)
                        }
                    }
                }
                
//                Section(header: Text("Dua")
//                    .font(.app.mTitle)
//                    .foregroundStyle(Color.app.highlight.gradient)
//                ) {
//                    ForEach(duas) { dua in
//                        NavigationLink(value: dua) {
//                            HStack {
//                                Text(dua.name.translation)
//                                    .foregroundStyle(Color.primary)
//                                Text(dua.sentencesRange)
//                                    .foregroundStyle(Color.secondary)
//                            }
//                            .font(.app.mTitle)
//                        }
//                    }
//                }
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
