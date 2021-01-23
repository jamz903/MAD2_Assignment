//
//  SignUpViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 21/1/21.
//

import Foundation
import FirebaseDatabase


class SignUpViewController: UIViewController{
    
    
    @IBOutlet weak var SignUpID: CustomUITextField!
    @IBOutlet weak var SignUpPW: CustomUITextField!
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpID.layer.cornerRadius = 10
        SignUpPW.layer.cornerRadius = 10
        
        SignUpID.setPlaceHolderImage(imageName: "studentid")
        SignUpPW.setPlaceHolderImage(imageName: "padlock")
        
//        LoginBtn.layer.cornerRadius = 10
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if SignUpID.text != "" && SignUpPW.text != "" {
            if let idEntered = SignUpID.text?.lowercased() {
                
                if let pwEntered = SignUpPW.text {
                    var profilesList: [Student] = [Student]()
                    ref.child("Profiles").observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = snapshot.value as! NSDictionary
                        
                        //get all the names
                        
                        let Keys : NSArray = (value.allKeys as! [String]) as NSArray
                        
                        for i in 0..<(Keys.count){
                            let guy = value[Keys[i]] as! NSDictionary
                            let student = Student(Name: Keys[i] as! String, PW: guy["PW"] as! String, Log: guy["Log"] as! String)
                            profilesList.append(student)
                        }
                        
                        var userExists: Bool = false
                        for i in profilesList {
                            if i.name == idEntered { // Student ID entered is already a registered account
                                print("Student ID already registered")
                                userExists = true
                                break
                            }
                        }
                        if !userExists {
                            let details = ["Log": "true", //by default
                                           "PW": pwEntered] as [String : Any]
                            self.ref.child("Profiles").child(idEntered).setValue(details)
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as UIViewController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                )}
            }
        }
    }
    
}
