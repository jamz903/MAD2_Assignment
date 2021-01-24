//
//  TaskRepository.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 21/1/21.
//

import Foundation
import FirebaseDatabase

class TaskRepository: ObservableObject {
    let ref = Database.database().reference().child("Profiles").child(LoginViewController.studentDetails.studentName)
    
    @Published var tasks = [Task]()
    var listSize = 0
    
    init(){
        loadData()
    }
    
    func loadData(){
        tasks.removeAll()
        self.ref.child("Tasks").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                let Tasks : NSArray = (value.allKeys as! [String]) as NSArray
                self.listSize = Tasks.count
                print("Task list size is: \(self.listSize)")
                for i in 0..<(Tasks.count) {
                    let taskNum = value[Tasks[i]] as! NSDictionary
                    let task = Task(id: Tasks[i] as! String, title: taskNum["title"] as! String, completed: (taskNum["completed"] as! Bool))
                    self.tasks.append(task)
                    for task in self.tasks {
                        print(task)
                    }
                    self.tasks.sort { $1.completed && !$0.completed }
                }
                print(value)
            }
            
            else{
                print("error retrieving data")
            }
            
        })
        
        
    }
    
    func addTask(_ task: Task) -> String {
        let taskNum = "Task\(self.listSize+1)"
        print(taskNum)
        if self.listSize != 0 {
            self.ref.child("Tasks").child(taskNum).child("completed").setValue(task.completed)
            self.ref.child("Tasks").child(taskNum).child("title").setValue(task.title)
            tasks.append(Task(id: taskNum, title: task.title, completed: task.completed))
            listSize = listSize + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                print(self.tasks[self.tasks.count - 1])
                self.tasks[self.tasks.count - 1].id = taskNum
            }
        }
        else{
            self.ref.child("Tasks").child(taskNum).child("completed").setValue(task.completed)
            self.ref.child("Tasks").child(taskNum).child("title").setValue(task.title)
            tasks.append(Task(id: "Task1", title: task.title, completed: task.completed))
            listSize = listSize + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
               // Code you want to be delayed
                print(self.tasks[self.tasks.count - 1])
                self.tasks[self.tasks.count - 1].id = taskNum
            }
            print("list empty")
        }
        
        return taskNum
    }
    
    func updateTask(_ task: Task){
        print(task.id)
        if task.id != nil {
            let taskID = task.id
            self.ref.child("Tasks").child(taskID!).child("completed").setValue(task.completed)
            self.ref.child("Tasks").child(taskID!).child("title").setValue(task.title)
        }
        
        else {
            print("no id")
        }
        
    }
    
    func removeTask(_ task: Task){
        let taskID = task.id
        self.ref.child("Tasks").child(taskID!).removeValue()
    }
    
}
