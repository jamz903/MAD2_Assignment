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
    
    init(){
        loadData()
    }
    
    func loadData(){
        self.ref.child("Tasks").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let Tasks : NSArray = (value.allKeys as! [String]) as NSArray
            for i in 0..<(Tasks.count-1) {
                let taskNum = value[Tasks[i]] as! NSDictionary
                let task = Task(id: Tasks[i] as! String, title: taskNum["title"] as! String, completed: (taskNum["completed"] != nil))
                self.tasks.append(task)
                for task in self.tasks {
                    print(task)
                }
            }
            
        })
        
        
    }
}
