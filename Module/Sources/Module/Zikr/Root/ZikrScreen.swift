//
//  ZikrScreen.swift
//  Module
//
//  Created by Khalil Sabirov on 28.01.2025.
//

import SwiftUI

struct ZikrScreen: View {
    
    @State private var count: Int = 0
    @State private var loopSize: LoopSize = .infinity
    @State private var currentLoopCount = 0
    @State private var loopsCount = 0
    @State private var zikrName = "ZikrName"
    
    var body: some View {
        Content(
            currentLoopCount: currentLoopCount,
            loopsCount: loopsCount,
            zikrName: zikrName,
            count: $count,
            loopSize: $loopSize
        )
        .safeAreaPadding()
    }
}

#Preview {
    NavigationStack {
        ZikrScreen()
    }
}

private struct Content: View {
    
    let currentLoopCount: Int
    let loopsCount: Int
    let zikrName: String
    @Binding var count: Int
    @Binding var loopSize: LoopSize
    
    var body: some View {
        VStack {
            Header(
                count: count,
                currentLoopCount: currentLoopCount,
                loopsCount: loopsCount,
                zikrName: zikrName,
                loopSize: $loopSize
            )
            Central()
            Footer()
        }
    }
}

private struct Header: View {
    
    private enum ViewState {
        case compact, full
    }
    
    let count: Int
    let currentLoopCount: Int
    let loopsCount: Int
    let zikrName: String
    @Binding var loopSize: LoopSize
    
    @State private var viewState: ViewState = .compact
    
    var body: some View {
        Group {
            switch viewState {
            case .compact:
                HeaderCompact(
                    count: count,
                    zikrName: zikrName,
                    loopSize: $loopSize
                )
            case .full:
                HeaderFull(
                    count: count,
                    currentLoopCount: currentLoopCount,
                    loopsCount: loopsCount,
                    zikrName: zikrName,
                    loopSize: $loopSize
                )
            }
        }
        .onChange(of: loopSize) {
            viewState = switch loopSize {
            case .infinity: .compact
            default: .full
            }
        }
    }
}

private struct Central: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

private struct Footer: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

private struct HeaderCompact: View {
    let count: Int
    let zikrName: String
    @Binding var loopSize: LoopSize
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                CountValueView(count: count)
                Spacer()
                LoopSizeSelectionView(loopSize: $loopSize)
            }
            ZikrNameView(name: zikrName)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct HeaderFull: View {
    let count: Int
    let currentLoopCount: Int
    let loopsCount: Int
    let zikrName: String
    @Binding var loopSize: LoopSize
    
    var body: some View {
        VStack(spacing: 6) {
            CountProgressView(
                currentLoopCount: currentLoopCount,
                loopsCount: loopsCount,
                zikrName: zikrName,
                loopSize: loopSize
            )
            
            HStack {
                CountValueView(count: count)
                Spacer()
                LoopSizeSelectionView(loopSize: $loopSize)
            }
        }
    }
}
