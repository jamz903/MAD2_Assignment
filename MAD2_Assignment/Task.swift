//
//  Task.swift
//  MAD2_Assignment
//
//  Created by Jamie on 16/1/21.
//

import Foundation
import UIKit

struct Task: Codable, Identifiable, Equatable {
    var id: String?
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


