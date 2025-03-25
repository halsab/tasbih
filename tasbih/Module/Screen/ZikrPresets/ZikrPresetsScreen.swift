//
//  ZikrPresetsScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 17.03.2025.
//

import SwiftUI

struct ZikrPresetsScreen: View {
    @Bindable var countService: CountService
    @Binding var name: String
    let onDismiss: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        countService: CountService,
        name: Binding<String>,
        onDismiss: @escaping () -> Void
    ) {
        self.countService = countService
        _name = name
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                InfoHeaderView(
                    image: .app.infoHeader.presets,
                    title: .text.title.zikrs,
                    description: .text.info.presetsHeader
                )
                .padding(.bottom, 8)
                
                ForEach(PresetZikr.presets) { preset in
                    Row(model: preset)
                        .onTapGesture {
                            name = preset.name
                            onDismiss()
                            dismiss()
                        }
                }
            }
            .safeAreaPadding()
        }
        .onAppear {
            name = ""
        }
    }
}

#Preview {
    NavigationStack {
        ZikrPresetsScreen(
            countService: CountService(modelContext: ZikrModel.previewContainer.mainContext),
            name: .constant("123")
        ) {}
    }
}
