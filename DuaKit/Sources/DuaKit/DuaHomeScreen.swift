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
                suraSection()
                duaSection()
            }
            .navigationTitle("Sura and Dua")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: DuaModel.self) { dua in
                DuaView(dua: dua)
            }
        }
    }
    
    @ViewBuilder
    private func suraSection() -> some View {
        Section(header: Text("Sura")
            .font(.app.font(.m, .bold))
            .foregroundStyle(Color.app.highlight.gradient)
        ) {
            ForEach(suras) { sura in
                NavigationLink(value: sura) {
                    row(for: sura)
                }
            }
        }
    }
    
    @ViewBuilder
    private func duaSection() -> some View {
        Section(header: Text("Dua")
            .font(.app.font(.m, .bold))
            .foregroundStyle(Color.app.highlight.gradient)
        ) {
            ForEach(duas) { dua in
                NavigationLink(value: dua) {
                    row(for: dua)
                }
            }
        }
    }
    
    @ViewBuilder
    private func row(for model: DuaModel) -> some View {
        var translationNameColor: Color {
            if model.isAlternativeNameExist {
                .system.secondaryLabel
            } else {
                .system.label
            }
        }
        var translationNameFont: Font {
            if model.isAlternativeNameExist {
                .app.font(.xxs)
            } else {
                .app.font(.m, .bold)
            }
        }
        
        VStack(alignment: .leading) {
            if let alternativeName = model.name.alternative {
                Text(alternativeName)
                    .foregroundStyle(Color.system.label)
                    .font(.app.font(.m, .bold))
            }
            
            HStack {
                Text(model.name.translation)
                    .foregroundStyle(translationNameColor)
                if !model.isFull {
                    Text(model.sentencesRange)
                        .foregroundStyle(Color.system.secondaryLabel)
                }
            }
            .font(translationNameFont)
        }
    }
}

#Preview {
    DuaHomeScreen()
        .tint(.app.tint)
}
