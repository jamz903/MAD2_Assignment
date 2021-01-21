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
        VStack(alignment: .leading, spacing: 0) {
            Text("Tasks").fontWeight(.bold).font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, CGFloat(15))
                .padding(.top)
                .padding(.bottom, CGFloat(15))
            VStack(alignment: .trailing) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                        
                    }
                    .onDelete(perform: { indexSet in
                        self.taskListVM.removeTasks(atOffsets: indexSet)
                    })
                    //adding new task
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task:  Task(title: "", completed: false))) { task in
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
        //TaskListView()
        TaskListView().environmentObject(TaskListViewModel())
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    var onCommit: (Task) -> (Void) = {_ in}
    var body: some View {
        HStack{
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                    print(taskCellVM.task.completed)
                    print("tapped")
                }
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
                .padding(.leading, CGFloat(8))
            .font(.system(size: CGFloat(20)))
            .padding(.top, CGFloat(8))
            .padding(.bottom, CGFloat(8))
        }
    }
}
