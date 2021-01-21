//
//  SignUpViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 21/1/21.
//

import Foundation
import FirebaseDatabase


class SignUpViewController: UIViewController{
    
    
    @IBOutlet weak var SignUpID: UITextField!
    @IBOutlet weak var SignUpPW: UITextField!
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        let details = ["Log": "true", //by default
                       "PW": SignUpPW.text] as [String : Any]
        self.ref.child("Profiles").child(SignUpID.text!).setValue(details)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
