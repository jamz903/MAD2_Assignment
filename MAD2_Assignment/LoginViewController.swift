//
//  LoginViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 16/1/21.
//

import Foundation
import FirebaseDatabase

class LoginViewController: UIViewController{
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Error: UILabel!
    let ref = Database.database().reference()
    
   
    var StudentList: [Student] = [Student]()
    override func viewDidLoad() {
        
        
        ref.child("Profiles").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            print("YUH")
            
            
            
            let count: Int = value.count ?? 0
            
            //get all the names
            
            let Keys : NSArray = (value.allKeys as! [String]) as NSArray
            
            print(Keys[1])
            for i in 0..<(Keys.count-1){
                let guy = value[Keys[i]] as! NSDictionary
                let student = Student(Name: Keys[i] as! String, PW: guy["PW"] as! String, Log: guy["Log"] as! String)
                self.StudentList.append(student)
            }
            
            print(self.StudentList[0].name)
            
            //let brain = value["Brian"] as! NSDictionary
            //print(type(of: brain))
            
            //print(value["Brian"])
            //print((brain["PW"] as! String))
            
        })
        super.viewDidLoad()
        
        
        

          
        }
        
    
    
    @IBAction func Login(_ sender: Any) {
        //read from database
        
        
        
        
        for i in StudentList{
            if i.name == Username.text{
                let guy: Student = i
                if(Password.text == guy.pw){
                    print("Beft")
                    
                    print(Password.text)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "LoginDone") as UIViewController
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true, completion: nil)
                
            }
                else{
                    Error.text = "Error"
                }
        }
        
        
        }
        
        
    }
    
}
