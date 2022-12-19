//
//  CalendarView.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var count: CountType = .first
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Count Type", selection: $count) {
                ForEach(CountType.allCases) {
                    Text($0.name)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            
            CalendarMonthView(count: count)
            
            Spacer()
        }
        .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
