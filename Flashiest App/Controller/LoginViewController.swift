//
//  LoginViewController.swift
//  Flashiest App
//
//  Created by Kavisha on 07/08/19.
//  Copyright © 2019 SoKa. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Login button implementation
    //TODO: Create a new user in the DB here
    @IBAction func loginButtonPressed(_ sender: Any) {
       // SVProgressHUD.show();
        
        SVProgressHUD.showSuccess(withStatus: "Yay")
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            
            if error != nil {
                print("error signing in");
            } else {
                print("User logged in successfully");
                
                SVProgressHUD.dismiss();
                self.performSegue(withIdentifier: "goToChat", sender: self);
            }
           
        }
   
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
