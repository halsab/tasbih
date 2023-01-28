//
//  CalendarView.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var cm: CountManager
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Count Type", selection: $cm.count) {
                ForEach(cm.counts) {
                    Text($0.name)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            
            CalendarMonthView()
            
            Spacer()
        }
        .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CountManager())
    }
}
