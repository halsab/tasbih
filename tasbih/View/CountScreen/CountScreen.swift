//
//  CountScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 25.09.2023.
//

import SwiftUI
import SwiftData

struct CountScreen: View {

    @StateObject var cm = CountManager()
    @Environment(\.modelContext) var modelContext
    @Query var counts: [CountModel]

    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                    .padding(.horizontal)
                    .padding(.top)

                CentralView()

                FooterView()
                    .padding(.horizontal)
            }
        }
        .environmentObject(cm)
    }

    private func addNewCount(_ model: CountModel) {
        modelContext.insert(model)
    }

    private func deleteCounts(_ indexSet: IndexSet) {
        for index in indexSet {
            let count = counts[index]
            modelContext.delete(count)
        }
    }
}

#Preview {
    CountScreen()
        .environmentObject(CountManager())
        .preferredColorScheme(.dark)
}
