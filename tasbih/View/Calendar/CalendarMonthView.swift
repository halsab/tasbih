//
//  CalendarMonthView.swift
//  muslimTools
//
//  Created by halsab on 14.11.2022.
//

import SwiftUI

struct CalendarMonthView: View {
    
    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var countManager: CountManager
    
    @State private var monthdays: [CountDay] = []
    @State private var selectedId: UUID = UUID()
    @State private var countInfo: String = "Select date to see count amount"
    @State private var infoTextColor: Color = .primary
    @State private var shortWeekdaySymbols: [String] = []
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                Text(Date().asString(format: .type2))
                    .textCase(.uppercase)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(appManager.tint.color)
                
//                LazyVGrid(columns: columns) {
//                    ForEach(shortWeekdaySymbols, id: \.self) { weekdaySymbol in
//                        Text(weekdaySymbol)
//                            .font(.system(.headline, design: .rounded))
//                            .foregroundColor(appManager.tint.color)
//                    }
//                }
//                .frame(maxWidth: .infinity)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(monthdays) { day in
                        if day.isCurrentMonthday {
                            Image(systemName: "\(day.dateString).circle.fill")
                                .symbolRenderingMode(.palette)
                                .font(.largeTitle)
                                .foregroundStyle(Color.bg, day.color)
                                .overlay(
                                    Circle()
                                        .stroke(isSelected(day) ? Color.primary : .clear, lineWidth: 4)
                                )
                                .onTapGesture {
                                    selectedId = day.id
                                    countInfo = "Total count \(day.count)/\(countManager.goal)"
                                    infoTextColor = day.color
                                }
                            
                            
                        } else {
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.clear)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            Text(countInfo)
                .padding()
                .frame(maxWidth: .infinity)
                .lineLimit(1)
                .font(.system(.headline, design: .rounded))
                .background(.secondary.opacity(0.3))
                .foregroundColor(infoTextColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onAppear {
            setupDays()
        }
    }
    
    private func setupDays() {
        shortWeekdaySymbols = Calendar.user.shortWeekdaySymbols
        let days = Calendar.user.monthdays()
        monthdays = days.map {
            countManager.countDay(at: $0)
        }
        
        if let today = monthdays.first(where: {
            Calendar.user.compare($0.date, to: Date.current(), toGranularity: .day) == .orderedSame
        }) {
            selectedId = today.id
            countInfo = "Total count \(today.count)/\(countManager.goal)"
            infoTextColor = today.color
        }
    }
    
    private func isSelected(_ day: CountDay) -> Bool {
        selectedId == day.id
    }
}

struct CalendarMonthView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(AppManager())
            .environmentObject(CountManager())
    }
}
