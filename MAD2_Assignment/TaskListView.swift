//
//  TaskListView.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 16/1/21.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    var body: some View {
        VStack {
            Text("Tasks").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, CGFloat(15))
            VStack(alignment: .trailing) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                    TaskCell(taskCellVM: taskCellVM)
                        
                    }
                    //adding new task
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task:  Task(Title: "", Completed: false))) { task in
                            self.taskListVM.addTask(task: task)
                            //whenever a new element is added, we will hide the new cell that appears after
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                
                Button(action: { self.presentAddNewItem.toggle()}) {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add New Task")
                    }
                }
                .padding(30)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = {_ in}
    
    var body: some View {
        HStack{
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill": "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture(count: 1, perform: {
                    taskCellVM.task.completed.toggle()
            })
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
                .padding(.leading, CGFloat(8))
        }
    }
}
