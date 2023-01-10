//
//  CalendarMonthView.swift
//  muslimTools
//
//  Created by halsab on 14.11.2022.
//

import SwiftUI

struct CalendarMonthView: View {
    
    let count: CountType
    
    @State private var monthdays: [CountDay] = []
    @State private var selectedId: UUID = UUID()
    @State private var countInfo: String = "No selected date"
    @State private var infoTextColor: Color = .gray2
    @State private var shortWeekdaySymbols: [String] = []
    
    private var countGoal: Int {
        count.loopSize * 3
    }
    
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
                    .font(.system(.headline))
                
                LazyVGrid(columns: columns) {
//                    Text("ПН")
//                    Text("ВТ")
//                    Text("СР")
//                    Text("ЧТ")
//                    Text("ПТ")
//                    Text("СБ")
//                    Text("ВС")
                    ForEach(shortWeekdaySymbols, id: \.self) { weekdaySymbol in
                        Text(weekdaySymbol)
                    }
                }
                .frame(maxWidth: .infinity)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(monthdays) { day in
                        if day.isCurrentMonthday {
                            Image(systemName: "\(day.dateString).circle.fill")
                                .symbolRenderingMode(.palette)
                                .font(.largeTitle)
                                .foregroundStyle(
                                    Color.bg,
                                    isSelected(day) ? Color.base : day.color(for: countGoal)
                                )
                                .overlay(
                                    Circle()
                                        .stroke(isSelected(day) ? Color.secondary : .clear, lineWidth: 4)
                                )
                                .onTapGesture {
                                    selectedId = day.id
                                    countInfo = "Total count \(day.count)/\(countGoal)"
                                    infoTextColor = day.color(for: countGoal)
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
            .padding(12)
            .background(Color.gray6)
            .cornerRadius(10)
            
            Text(countInfo)
                .padding()
                .frame(maxWidth: .infinity)
                .lineLimit(1)
                .font(.system(.headline))
                .background(.secondary.opacity(0.3))
                .foregroundColor(infoTextColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onAppear {
            setupDays()
        }
    }
    
    private func setupDays() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: "ru_RU") as Locale
        calendar.firstWeekday = 1
        shortWeekdaySymbols = calendar.shortWeekdaySymbols
        Log.debug(calendar.shortWeekdaySymbols)
        let days = calendar.monthdays()
        monthdays = days.map {
            CountDay(date: $0, count: Int.random(in: 0..<countGoal))
        }
    }
    
    private func isSelected(_ day: CountDay) -> Bool {
        selectedId == day.id
    }
}

struct CalendarMonthView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
//            .preferredColorScheme(.dark)
            .preferredColorScheme(.light)
    }
}
