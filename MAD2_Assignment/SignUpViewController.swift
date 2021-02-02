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
    @IBOutlet weak var errorText: UILabel!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpID.layer.cornerRadius = 10
        SignUpPW.layer.cornerRadius = 10
        signUpBtn.layer.cornerRadius = 10
        
        SignUpID.setPlaceHolderImage(imageName: "studentid")
        SignUpPW.setPlaceHolderImage(imageName: "padlock")
        
//        LoginBtn.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    //back to login page
    @IBAction func backToLoginBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //sign up button pressed
    @IBAction func SignUp(_ sender: Any) {
        
        //check that the 2 datafields are not empty
        if SignUpID.text != "" && SignUpPW.text != "" {
            //make id entered variable into the text in the datafield
            if let idEntered = SignUpID.text?.lowercased() {
                // Checks that user has entered in a valid Student ID format (e.g. s12345678)
                if idEntered[idEntered.startIndex] == "s" && Int(idEntered.suffix(8)) != nil {
                    //made pw entered variable into the text of the textfield
                    if let pwEntered = SignUpPW.text {
                        var profilesList: [Student] = [Student]()
                        
                        //create reference for the firebase database
                        ref.child("Profiles").observeSingleEvent(of: .value, with: { [self] (snapshot) in
                            //set the values of the push data as a dictionary
                            let value = snapshot.value as! NSDictionary
                            
                            //get all the names
                            //add the keys from the database into an array
                            let Keys : NSArray = (value.allKeys as! [String]) as NSArray
                            
                            //add new member into variable before pushing it to the database
                            for i in 0..<(Keys.count){
                                let guy = value[Keys[i]] as! NSDictionary
                                let student = Student(Name: Keys[i] as! String, PW: guy["PW"] as! String, Log: guy["Log"] as! String)
                                profilesList.append(student)
                            }
                            
                            //variable for later to check if the user has been created ebfore
                            var userExists: Bool = false
                            for i in profilesList {
                                if i.name == idEntered { // Student ID entered is already a registered account
                                    print("Student ID already registered")
                                    userExists = true
                                    errorText.text = "Student ID already registered"
                                    break
                                }
                            }
                            if !userExists {//push the value to the database
                                let details = ["Log": "false", //by default
                                               "PW": pwEntered] as [String : Any]
                                self.ref.child("Profiles").child(idEntered).setValue(details)
                                
                                dismiss(animated: true, completion: nil)
                            }
                        }
                    )}
                }
                else {
                    errorText.text = "Invalid Student ID"
                }
            }
        }
    }
    
}
