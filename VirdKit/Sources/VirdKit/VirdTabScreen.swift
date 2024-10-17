//
//  VirdTabScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 06.10.2024.
//

import SwiftUI
import HelperKit

struct VirdTabScreen: View {
    
    @AppStorage(.storageKey.vird.book) private var book = 0
    @AppStorage(.storageKey.vird.tafsir) private var tafsir = 0
    @AppStorage(.storageKey.vird.quran) private var quran = 0
    @AppStorage(.storageKey.vird.zikr) private var zikr = 0
    @AppStorage(.storageKey.vird.uraza) private var uraza = 0
    @AppStorage(.storageKey.vird.tahadjud) private var tahadjud = 0
    @AppStorage(.storageKey.vird.ishrak) private var ishrak = 0
    @AppStorage(.storageKey.vird.duha) private var duha = 0
    @AppStorage(.storageKey.vird.avvabin) private var avvabin = 0
    @AppStorage(.storageKey.vird.shukurVudu) private var shukurVudu = 0
    @AppStorage(.storageKey.vird.quranAfterNamaz) private var quranAfterNamaz = 0
    
    var body: some View {
        List {
            activityView(name: "Book", value: $book)
            activityView(name: "Tafsir", value: $tafsir)
            activityView(name: "Quran", value: $quran)
            activityView(name: "Zikr", value: $zikr)
            activityView(name: "Uraza", value: $uraza)
            activityView(name: "Tahadjud", value: $tahadjud)
            activityView(name: "Ishrak", value: $ishrak)
            activityView(name: "Duha", value: $duha)
            activityView(name: "Avvabin", value: $avvabin)
            activityView(name: "ShukurVudu", value: $shukurVudu)
            activityView(name: "Quran after namaz", value: $quranAfterNamaz)
        }
    }
    
    @ViewBuilder
    private func activityView(name: String, value: Binding<Int>) -> some View {
        HStack {
            Text(name)
                .font(.headline)
            
            
            Stepper(value: value) {
                Text("")
            }

            TextField("Value", value: value, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 75)

        }
    }
}

#Preview {
    VirdTabScreen()
}
