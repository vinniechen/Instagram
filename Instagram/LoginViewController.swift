//
//  LoginViewController.swift
//  Instagram
//
//  Created by Vinnie Chen on 3/30/17.
//  Copyright © 2017 Vinnie Chen. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("user nil")
            }
        }
        
        /*PFUser.logInWithUsername(inBackground: self.usernameTextField.text!, password: self.passwordTextField.text!, block: { (user: PFUser?, error: Error?) in
            if user != nil {
                print("logged in")
            } else {
                print("user nil")
            } */
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Created User")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error!.localizedDescription)
            }
        }
        
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
