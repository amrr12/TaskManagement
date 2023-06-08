//
//  NewTask.swift
//  TaskApp
//
//  Created by amr on 08/06/2023.
//

import SwiftUI

struct NewTask: View {
    @Environment(\.dismiss) var dismiss
    @State var taskTitle : String = ""
    @State var taskDescription : String = ""
    @State var taskDate : Date = Date()
    
    @Environment(\.managedObjectContext) var context
    var body: some View {
        NavigationView{
            List{
                
                Section {
                    TextField("go to work",text:$taskTitle)
                }header: {
                    Text("Task Title")
                }
                Section {
                    TextField("task description ...",text:$taskDescription)
                }header: {
                    Text("Task Description")
                }
                Section {
                    DatePicker("",selection: $taskDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }header: {
                    Text("Task Date")
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        
                        let task = Task(context: context)
                        task.taskTitle = taskTitle
                        task.taskDescription = taskDescription
                        task.taskDate = taskDate
                        
                        try? context.save()
                        dismiss()
                        
                    }.disabled(taskTitle == "" || taskDescription == "")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }.foregroundColor(.black)
                }
            }
        }
    }
}


