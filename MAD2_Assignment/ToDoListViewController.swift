//
//  ToDoListViewController.swift
//  MAD2_Assignment
//
//  Created by Jamie on 18/1/21.
//

import Foundation
import UIKit
import SwiftUI

class ToDoListViewController: UIHostingController<TaskListView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: TaskListView())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Do any additional setup after loading the view
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Tasks";
    }

}
