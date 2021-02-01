//
//  LoginViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 16/1/21.
//

import Foundation
import FirebaseDatabase

class LoginViewController: UIViewController{
    
    //set variables for storyboard
    @IBOutlet weak var Username: CustomUITextField!
    @IBOutlet weak var Password: CustomUITextField!
    @IBOutlet weak var Error: UILabel!
    @IBOutlet weak var LoginBtn: UIButton!
    
    
    //start reference for firebase database
    let ref = Database.database().reference()
    
    let preferences = UserDefaults.standard
    
   //create students list to hold student info
    var StudentList: [Student] = [Student]()
    
    //create struct to recieve data from firebase
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
        
        

    }
        
    
    
    @IBAction func Login(_ sender: Any) {
        
        //careate profiles lists to hold profiles
        var profilesList: [Student] = [Student]()
        
        //send request and view profiles info 1 time when the app starts
        ref.child("Profiles").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //add all values into a readable dictionary
            let value = snapshot.value as! NSDictionary
            
            //get all the names
            
            let Keys : NSArray = (value.allKeys as! [String]) as NSArray
            
            print(Keys[1])//test
            
            //add data into dictionary with keys set in
            for i in 0..<(Keys.count){
                let guy = value[Keys[i]] as! NSDictionary
                let student = Student(Name: Keys[i] as! String, PW: guy["PW"] as! String, Log: guy["Log"] as! String)
                profilesList.append(student)
            }
            
            //debug testing
            for guy in profilesList {
                print(guy.name)
                print(guy.pw)
                //self.preferences.set(guy.name, forKey: "userName")
            }
            
            
            //debug testing
            print("running")
            print("profileList has \(profilesList.count)")
            
            
            print("User entered in name as \(self.Username.text!)")
            //read from database
            
            // Checks if User has entered in anything in the username/student ID field
            if let nameEntered = self.Username.text {
                var userExists = false
                for i in profilesList{
                    
                    //set all names to lowercase for checking purposes
                    if i.name == nameEntered.lowercased() {
                        userExists = true
                        let profile: Student = i
                        
                        if i.log == "true"{
                            self.Error.text = "User is already logged in on another device"
                        }
                        else{//user has successfully logged in
                            if self.Password.text == profile.pw {
                                print(self.Password.text)
                                LoginViewController.studentDetails.studentName = profile.name
                                LoginViewController.studentDetails.studentPassword = profile.log
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(identifier: "LoginDone") as UIViewController
                                vc.modalPresentationStyle = .fullScreen
                                //move to next section in storyboard
                                self.present(vc, animated: true, completion: nil)
                            
                            }
                            else{//if user enters in wrong credentials
                                self.Error.text = "Incorrect credentials, please try again"
                            }
                        }
                         
                    }
                }
                if !userExists {//if user does not exist
                    self.Error.text = "User does not exist"
                }
            }
             
        })
    }
    
    //sign up button to move to sign up page
    @IBAction func SignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUpViewController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    
}
