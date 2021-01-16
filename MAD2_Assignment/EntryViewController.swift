//
//  EntryViewController.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 14/1/21.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var field: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        field.delegate = self
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    @IBAction func saveTask(_ sender: Any) {
        guard let text = field.text, !text.isEmpty else{
            return
        }
        guard let count = (UserDefaults().value(forKey: "count") as? Int) else{
            return
        }
        
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask(self)
        return true
    }
    
//    @objc func saveTask(){
//        guard let text = field.text, !text.isEmpty else{
//            return
//        }
//        guard let count = (UserDefaults().value(forKey: "count") as? Int) else{
//            return
//        }
//
//        let newCount = count + 1
//        UserDefaults().set(newCount, forKey: "count")
//        UserDefaults().set(text, forKey: "task_\(newCount)")
//
//        update?()
//
//        self.navigationController?.popViewController(animated: true)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
