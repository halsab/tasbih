//
//  CountView.swift
//  muslimTools
//
//  Created by halsab on 10.11.2022.
//

import SwiftUI

struct CountView: View {
    
    @ObservedObject var vm = CountViewModel()
    @State private var showCalendar = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bg
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Loops: \(vm.loops)")
                        Spacer()
                        Text("Total: \(vm.total)")
                    }
                    .foregroundColor(.secondary)
                    
                    Button {
                        vm.increment()
                    } label: {
                        Text("\(vm.value)")
                            .modifier(LargeCountButtonTextStyle())
                    }
                    
                    HStack {
                        Button {
                            vm.reset()
                        } label: {
                            Text("Reset")
                                .modifier(TintButtonTextStyle())
                        }
                        
                        Button {
                            vm.decrement()
                        } label: {
                            Text("Undo")
                                .modifier(TintButtonTextStyle())
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCalendar.toggle()
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Picker("Count Type", selection: $vm.count) {
                        ForEach(CountType.allCases) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }
            .sheet(isPresented: $showCalendar) {
                CalendarView()
            }
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
    }
}
