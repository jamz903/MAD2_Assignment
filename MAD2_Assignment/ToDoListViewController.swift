//
//  ToDoListViewController.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 18/1/21.
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
