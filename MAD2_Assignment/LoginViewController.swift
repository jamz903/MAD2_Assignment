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
    let ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Login(_ sender: Any) {
        //read from database
        var checkpassword = ""
        
        ref.child("Profiles/"+Username.text!).observeSingleEvent(of: .value) { (snapshot) in
            checkpassword = (snapshot.value as? String)!
            print(checkpassword)
        }
        
        if(Password.text == checkpassword){
            print("Beft")
            print(checkpassword)
            print(Password.text)
            performSegue(withIdentifier: "about", sender: sender)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Content") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
    }
    
}
