//
//  LoginViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 16/1/21.
//

import Foundation
import FirebaseDatabase

class LoginViewController: UIViewController{
    
    @IBOutlet weak var Username: CustomUITextField!
    @IBOutlet weak var Password: CustomUITextField!
    @IBOutlet weak var Error: UILabel!
    @IBOutlet weak var LoginBtn: UIButton!
    
    let ref = Database.database().reference()
    let preferences = UserDefaults.standard
    
   
    var StudentList: [Student] = [Student]()
    
    struct studentDetails {
        static var studentName = ""
        static var studentPassword = ""
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Designing text fields in login screen
        Username.layer.cornerRadius = 10
        Password.layer.cornerRadius = 10
        
        Username.setPlaceHolderImage(imageName: "studentid")
        Password.setPlaceHolderImage(imageName: "padlock")
        
        LoginBtn.layer.cornerRadius = 10
        
        
//        ref.child("Profiles").observeSingleEvent(of: .value, with: { (snapshot) in
//            let value = snapshot.value as! NSDictionary
//            print("YUH")
//
//
//
//            let count: Int = value.count ?? 0
//
//            //get all the names
//
//            let Keys : NSArray = (value.allKeys as! [String]) as NSArray
//
//            print(Keys[1])
//            for i in 0..<(Keys.count-1){
//                let guy = value[Keys[i]] as! NSDictionary
//                let student = Student(Name: Keys[i] as! String, PW: guy["PW"] as! String, Log: guy["Log"] as! String)
//                self.StudentList.append(student)
//            }
//
//            for guy in self.StudentList{
//                print(guy.name)
//                print(guy.pw)
//                //self.preferences.set(guy.name, forKey: "userName")
//
//
//            }
//
//
//        })
    }
        
    
    
    @IBAction func Login(_ sender: Any) {
        
        var profilesList: [Student] = [Student]()
        ref.child("Profiles").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            
            //get all the names
            
            let Keys : NSArray = (value.allKeys as! [String]) as NSArray
            
            print(Keys[1])
            for i in 0..<(Keys.count){
                let guy = value[Keys[i]] as! NSDictionary
                let student = Student(Name: Keys[i] as! String, PW: guy["PW"] as! String, Log: guy["Log"] as! String)
                profilesList.append(student)
            }
            
            for guy in profilesList {
                print(guy.name)
                print(guy.pw)
                //self.preferences.set(guy.name, forKey: "userName")
            }
            
            print("running")
            print("profileList has \(profilesList.count)")
            
            
            print("User entered in name as \(self.Username.text!)")
            //read from database
            
            // Checks if User has entered in anything in the username/student ID field
            if let nameEntered = self.Username.text {
                var userExists = false
                for i in profilesList{
                    if i.name == nameEntered.lowercased() {
                        userExists = true
                        let profile: Student = i
                        
                        if i.log == "true"{
                            self.Error.text = "User is already logged in on another device"
                        }
                        else{
                            if self.Password.text == profile.pw {
                                print(self.Password.text)
                                LoginViewController.studentDetails.studentName = profile.name
                                LoginViewController.studentDetails.studentPassword = profile.log
                                //self.ref.child("Profiles/" + i.name + "/Log").setValue("true")
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(identifier: "LoginDone") as UIViewController
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            
                            }
                            else{
                                self.Error.text = "Incorrect credentials, please try again"
                            }
                        }
                         
                    }
                }
                if !userExists {
                    self.Error.text = "User does not exist"
                }
            }
             
        })
    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUpViewController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    
}
