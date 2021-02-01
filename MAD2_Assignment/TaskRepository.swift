//
//  TaskRepository.swift
//  MAD2_Assignment
//
//  Created by Jamie on 21/1/21.
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
    
    //loads tasklist data from firebase
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
    
    //adds task to firebase & list
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
    
    //updates task title in firebase & list (when enter is pressed)
    func updateTask(_ task: Task){
        print(task.id)
        if task.id != nil {
            let taskID = task.id
            self.ref.child("Tasks").child(taskID!).child("title").setValue(task.title)
            //loadData()
            
            var index = tasks.firstIndex(of: task)
            if index != nil {
                tasks[index!].title = task.title
            }
            else {
                tasks[0].title = task.title
            }
        }
        
        else {
            print("no id")
        }
        
    }
    
    //updates completed status in firebase & in list (every 0.8 seconds)
    func updateTick(_ task: Task) {
        print(task.id)
        if task.id != nil {
            let taskID = task.id
            self.ref.child("Tasks").child(taskID!).child("completed").setValue(task.completed)
            //loadData()
            
            var index = tasks.firstIndex(of: task)
            if index != nil {
                tasks[index!].completed = task.completed
            }
            else {
                tasks[0].completed = task.completed
            }
        }
        
        else {
            print("no id")
        }
    }
    
    //removes task from firebase & list when deleted
    func removeTask(_ task: Task){
        let taskID = task.id
        self.ref.child("Tasks").child(taskID!).removeValue()
        var index = tasks.firstIndex(of: task)!
        tasks.remove(at: index)
    }
    
}
