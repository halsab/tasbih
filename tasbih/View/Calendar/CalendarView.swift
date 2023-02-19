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
        VStack {
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
