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
    
    @ViewBuilder
    private func duaSection() -> some View {
        Section(header: Text("Dua")
            .font(.app.font(.m, .bold))
            .foregroundStyle(Color.app.highlight.gradient)
        ) {
            ForEach(duas) { sura in
                NavigationLink(value: sura) {
                    Text(sura.name.translation)
                        .font(.app.font(.m, .bold))
                        .foregroundStyle(Color.system.label)
                }
            }
        }
    }
}

#Preview {
    DuaHomeScreen()
        .tint(.app.tint)
}
