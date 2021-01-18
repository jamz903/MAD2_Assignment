//
//  Task.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 16/1/21.
//

import Foundation
import UIKit

class Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool
    
    init(Title:String, Completed:Bool){
        title = Title
        completed = Completed
    }
}


#if DEBUG
let testDataTasks = [
Task(Title: "Implement the UI", Completed: true),
Task(Title: "Connect to Firebase", Completed: false),
Task(Title: "Complete the Login Screen", Completed: false),
Task(Title: "Hello", Completed: false)]
#endif


