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
    
    @State private var searchText = ""
    
    private var surasSearchResults: [DuaModel] {
        if searchText.isEmpty {
            return suras
        } else {
            return suras.filter { $0.searchKey.contains(searchText) }
        }
    }
    private var duasSearchResults: [DuaModel] {
        if searchText.isEmpty {
            return duas
        } else {
            return duas.filter { $0.searchKey.contains(searchText) }
        }
    }
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                if !surasSearchResults.isEmpty {
                    suraSection()
                }
                if !duasSearchResults.isEmpty {
                    duaSection()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: DuaModel.self) { dua in
                DuaView(dua: dua)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .searchable(text: $searchText)
    }
    
    @ViewBuilder
    private func sectionHeader(name: String) -> some View {
        Text(name)
            .font(.app.font(.m, .bold))
            .foregroundStyle(Color.app.tint.gradient)
    }
    
    @ViewBuilder
    private func suraSection() -> some View {
        Section(header: sectionHeader(name: "sura")) {
            ForEach(surasSearchResults) { sura in
                NavigationLink(value: sura) {
                    row(for: sura)
                }
            }
        }
    }
    
    @ViewBuilder
    private func duaSection() -> some View {
        Section(header: sectionHeader(name: "dua")) {
            ForEach(duasSearchResults) { dua in
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
