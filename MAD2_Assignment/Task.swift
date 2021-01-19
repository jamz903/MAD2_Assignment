//
//  Task.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 16/1/21.
//

import Foundation
import UIKit

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool
}


#if DEBUG
let testDataTasks = [
Task(title: "Implement the UI", completed: true),
Task(title: "Connect to Firebase", completed: false),
Task(title: "Complete the Login Screen", completed: false),
Task(title: "Hello", completed: false)]
#endif


