//
//  InfoHeaderView.swift
//  tasbih
//
//  Created by Khalil Sabirov on 11.02.2025.
//

import SwiftUI

struct InfoHeaderView: View {
    let image: Image
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 16) {
            image
                .symbolRenderingMode(.palette)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.shape(.white), Color.shape(.app.tint.primary))
                .bold()
                .frame(height: 64)
                .clipShape(.rect(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.shape(.white), lineWidth: 1)
                )
            
            Text(title)
                .font(.app.font(.l, weight: .bold))
            
            Text(description)
                .font(.app.font(.m))
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.background.secondary)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    InfoHeaderView(
        image: .app.infoHeader.zikrs,
        title: .text.title.zikrs,
        description: .text.info.zikrsHeader
    )
    .safeAreaPadding()
}
