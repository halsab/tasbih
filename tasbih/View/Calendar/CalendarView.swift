//
//  CalendarView.swift
//  muslimTools
//
//  Created by halsab on 19.11.2022.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var countManager: CountManager
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Count Type", selection: $countManager.selectedCountId) {
                ForEach(countManager.counts, id: \.id) {
                    Text("\($0.loopSize)").tag($0.id)
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
