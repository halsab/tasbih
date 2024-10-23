//
//  ZikrEditView.swift
//  ZikrKit
//
//  Created by Khalil Sabirov on 23.10.2024.
//

import SwiftUI

struct ZikrEditView: View {
    
    @Bindable var zikr: ZikrModel
    @FocusState private var isFocused: Bool
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    var body: some View {
        Form {
            TextField("Total count", value: $zikr.count, formatter: formatter)
                .keyboardType(.numberPad)
                .focused($isFocused)
                
            DatePicker("Date", selection: $zikr.date, displayedComponents: .date)
                .datePickerStyle(.compact)
        }
        .navigationTitle(zikr.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}
