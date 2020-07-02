//
//  RegisterViewController.swift
//  Flashiest App
//
//  Created by Kavisha on 07/08/19.
//  Copyright © 2019 SoKa. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - Register button pressed
    //TODO: Implement the sign in method
    @IBAction func registerButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){
            (user, error) in
            
            if error != nil {
                print("Error ocurred on user creation");
            } else {
                print("User created successfully with email \(self.emailTextField.text!)");
                
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
