//
//  TaskViewModel.swift
//  taskManagement
//
//  Created by amr on 03/06/2023.
//

import SwiftUI


class TaskViewModel  : ObservableObject {
    
    @Published var currentWeek : [Date] = []
    @Published var currentDay : Date = Date()
    @Published var filtredTask : [Task]?
    @Published var addNewTask : Bool = false 
       
    
    func fetchCurrentWeek () {
        let today = Date()
        let calendar = Calendar.current
        let week  = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else {return}
        
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate (date: Date, format : String) -> String {
        let  formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isToday(date : Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    
    init() {
        fetchCurrentWeek()
    }
    
}
