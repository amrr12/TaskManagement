//
//  TaskInfo.swift
//  TaskApp
//
//  Created by amr on 08/06/2023.
//

import SwiftUI
import CoreData

struct TaskInfo: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context

    var task : Task
    @State var isEditActive = false
    @State var taskTitle: String
    @State var taskDescription: String
    @State var taskDate: Date
    
    init(task: Task){
        self.task = task
        _taskTitle = State(initialValue: task.taskTitle ?? "")
        _taskDescription = State(initialValue: task.taskDescription ?? "")
        _taskDate = State(initialValue: task.taskDate ?? Date())

    }

    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("go to work",text:$taskTitle)
                        .disabled(isEditActive ? false : true)
                }header: {
                    Text("Task Title")
                }
                Section {
                    TextField("task description ...",text:$taskDescription)
                        .disabled(isEditActive ? false : true)
                }header: {
                    Text("Task Description")
                }
                Section {
                    DatePicker("",selection: $taskDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .disabled(isEditActive ? false : true)
                }header: {
                    Text("Task Date")
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationBarHidden(true)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("<")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text("BACK")
                            .padding(.top,2)
                            .foregroundColor(.black)
                    }
                    
                }

            }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if isEditActive {
                        do {
                            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
                            fetchRequest.predicate = NSPredicate(format: "taskTitle == %@", task.taskTitle!)
                            
                            let results = try context.fetch(fetchRequest)
                                    if let taskk = results.first {
                                        taskk.taskTitle = taskTitle
                                        taskk.taskDescription = taskDescription
                                        taskk.taskDate = taskDate
                                        try context.save()
                                    }
                        }catch {
                            print("update not working")
                        }

                        
                    }
                    isEditActive.toggle()
                    
                    
                } label: {
                    HStack {
                        Text(isEditActive ? "Save" : "Edit")
                            .padding(.top,2)
                            .foregroundColor(.black)
                    }
                    
                }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "taskTitle == %@", task.taskTitle!)
                               
                               do {
                                   let results = try context.fetch(fetchRequest)
                                   if let taskToDelete = results.first {
                                       context.delete(taskToDelete)
                                       try context.save()
                                       
                                   }
                               } catch {
                                   print("Error deleting task: \(error)")
                               }
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Delete")
                            .padding(.top,2)
                            .foregroundColor(.red)
                    }
                    
                }

            }
            }
            
        
    }
}


