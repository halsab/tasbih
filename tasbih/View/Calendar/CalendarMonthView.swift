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
    @State private var countInfo: String = ""
    
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
                    Text("ПН")
                    Text("ВТ")
                    Text("СР")
                    Text("ЧТ")
                    Text("ПТ")
                    Text("СБ")
                    Text("ВС")
                }
                .frame(maxWidth: .infinity)
                
                LazyVGrid(columns: columns) {
                    ForEach(monthdays) { day in
                        if day.isCurrentMonthday {
                            Image(systemName: "\(day.dateString).circle.fill")
                                .symbolRenderingMode(.palette)
                                .font(.largeTitle)
                                .foregroundStyle(
                                    isSelectedDay(day) ? Color.bg : .primary,
                                    isSelectedDay(day) ? Color.base : day.color(for: countGoal).opacity(0.5)
                                )
                                .onTapGesture {
                                    selectedId = day.id
                                    countInfo = "Total count \(day.count)/\(countGoal)"
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
                .fontWeight(.semibold)
        }
        .onAppear {
            setupDays()
        }
    }
    
    private func setupDays() {
        let calendar = Calendar.current
        let days = calendar.filledMonthdays()
        monthdays = days.map {
            CountDay(date: $0, count: Int.random(in: 0..<countGoal))
        }
    }
    
    private func isSelectedDay(_ day: CountDay) -> Bool {
        selectedId == day.id
    }
}

struct CalendarMonthView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
//            .preferredColorScheme(.dark)
    }
}
