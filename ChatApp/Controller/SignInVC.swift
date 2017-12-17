//
//  ViewController.swift
//  ChatApp
//
//  Created by Kanishk Verma on 16/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    private let CONTACTS_SEGUE = "contactsSegue"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        if AuthProvider.instance.isLogOut() {
            performSegue(withIdentifier: "contactsSegue", sender: nil)
        }
    }

    @IBAction func logInBtnPressed(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            AuthProvider.instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: {
                (message) in
                if message != nil {
                    self.alertTheUser(title: "Problem with Authentication", message: message!)
                } else {
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: self.CONTACTS_SEGUE, sender: nil)

                }
            } )
        } else {
            self.alertTheUser(title: "Fields Missing", message: "Enter the email and the password")
        }
    } // LoginBtnPressed
    
    @IBAction func signUpBtnPressed(_ sender: AnyObject) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            AuthProvider.instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Problem with creating the NEW USER", message: message!)
                } else {
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: self.CONTACTS_SEGUE, sender: nil);
                }
            })
            
        } else {
            self.alertTheUser(title: "Fields Missing", message: "Enter the email and the password")
        }
        
    }//signUpBtnPressed
    
    private func alertTheUser(title:String, message :String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }//alertTheUser
    
    
    
} //class

