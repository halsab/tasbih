//
//  TafsirView.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 05.11.2024.
//

import SwiftUI

struct TafsirView: View {
    
    let duaName: String
    let sentenceNumber: Int?
    let tafsir: DuaModel.Sentence.Tafsir
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(tafsir.text)
                    .font(.app.font(.m))
                    .foregroundStyle(Color.system.secondaryLabel)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    VStack {
                        HStack {
                            Text(duaName)
                            Text("-")
                            if let sentenceNumber {
                                Text("\(sentenceNumber)")                                
                            }
                        }
                        .font(.app.font(.m, .bold))
                        .foregroundStyle(Color.system.secondaryLabel)

                        Text(tafsir.author)
                            .font(.app.font(.xs))
                            .foregroundStyle(Color.system.tertiaryLabel)
                    }
                }
            }
        }
    }
}

#Preview {
    TafsirView(
        duaName: "Bakara",
        sentenceNumber: 183,
        tafsir: _5_Bakara.sentences.first!.tafsir!
    )
    .tint(.app.tint)
}
