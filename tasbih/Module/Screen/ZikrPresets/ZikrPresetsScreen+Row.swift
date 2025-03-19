//
//  ZikrPresetsScreen+Row.swift
//  tasbih
//
//  Created by Khalil Sabirov on 19.03.2025.
//

import SwiftUI

extension ZikrPresetsScreen {
    struct Row: View {
        let model: PresetZikr
        
        var body: some View {
            VStack(alignment: .center, spacing: 8) {
                Text(model.name)
                    .font(.app.font(.l, weight: .bold))
                    .foregroundStyle(.shape(.app.tint.secondary))
                if let transcription = model.description {
                    Text("(\(transcription))")
                        .font(.app.font(.s))
                        .foregroundStyle(.secondary)
                }
                if let translation = model.translation {
                    Text(translation)
                        .font(.app.font(.m, weight: .bold))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(String.text.presets.honorsTitle):")
                        .font(.app.font(.s))
                    ForEach(model.honors, id: \.self) {
                        Text("⭐️ ")
                            .font(.app.font(.xs)) +
                        Text($0)
                            .font(.app.font(.s))
                            .foregroundStyle(.secondary)
                    }
                }
                .multilineTextAlignment(.leading)
                .padding(.top, 8)
            }
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.background.secondary)
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}

#Preview {
    ZikrPresetsScreen.Row(model: .presets.first!)
}
