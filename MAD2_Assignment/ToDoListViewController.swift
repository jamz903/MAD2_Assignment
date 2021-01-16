//
//  ToDoListViewController.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 14/1/21.
//

import Foundation
import UIKit
class ToDoListViewController: UIViewController {
    var tasks = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    //test push
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tasks"
        
        //Setup
        if UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set("0", forKey: "count")
        }
        
        //Get all current saved tasks
        updateTasks()
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //no of rows is the no. of tasks
            return tasks.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = tasks[indexPath.row]
            return cell
        }
    }
    
    func updateTasks() {
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task:_\(x)") as? String {
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }


}

//extension ViewController: UITableViewDelegate {
//
//
//}
//
//extension ViewController: UITableViewDataSource {
//
//
//
//}
