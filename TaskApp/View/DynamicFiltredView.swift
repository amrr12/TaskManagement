//
//  DynamicFiltredView.swift
//  TaskApp
//
//  Created by amr on 08/06/2023.
//

import SwiftUI
import CoreData

struct DynamicFiltredView<Content: View,T>: View where T : NSManagedObject{
    
    @FetchRequest var request : FetchedResults<T>
    
    let content : (T)->Content
    
    init(dateToFilter : Date,@ViewBuilder content : @escaping (T)->Content) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: dateToFilter)
        let tommorow = calendar.date(byAdding: .day, value: 1, to: dateToFilter)
        let filterkey = "taskDate"
        let predicate = NSPredicate(format: "\(filterkey) >= %@ AND \(filterkey) < %@", argumentArray: [today,tommorow])
        
        
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: predicate)
        self.content = content
    }
    var body: some View {
        Group {
            if request.isEmpty {
                Text("No Tasks Found !!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y:100)
            }else {
                ForEach(request, id:\.objectID) { object in
                    self.content(object)
                }
            }
        }
    }
}

