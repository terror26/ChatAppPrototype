//
//  File.swift
//  ChatApp
//
//  Created by Kanishk Verma on 17/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import Foundation
import Firebase

typealias LoginHandler = (_ msg: String?) -> Void;

struct LoginErrorCode {
    
    static let INVALID_EMAIL = "Invalid Email Address,Please Provide a Real Email Address"
    static let WRONG_PASSWORD  = "Wrong Paswword,Enter the Correct password"
    static let  PROBLEM_CONNECTING = "PROBLEM CONECTING TO DATABASE,Please Try Later"
    static let USER_NOT_FOUND = "User not found,Please Register"
    static let EMAIL_ALREADY_IN_USE = "Email alredy in user please use another email"
    static let WEAK_PAASOWORD = "Password should be atleast 6 character Long"
    
} // LoginInErrorCode

class AuthProvider {
    
    private static  var _instance  = AuthProvider()
    
    static var instance:AuthProvider {
        return _instance
    }
    
    var userName = "";
    
    func login(withEmail : String , password : String, loginHandler : LoginHandler? ) {
        
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler)
                print("++++++++Some error with the firebase authentication ++++++++")
                
            } else {
                loginHandler?(nil)
            }
            
            })
        
    } // Login func
    
    func signUp(withEmail: String, password:String, loginHandler: LoginHandler?) {
        
        Auth.auth().createUser(withEmail: withEmail, password: password, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler)
            } else {
                if user?.uid != nil {
                    
                    //Store the data in the database
                    DBProvider.instance.saveUser(withID: user!.uid, email: withEmail, password: password);
                    
                    //TO authenticate that the provided stuff is real and valid
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler)
                }
            }
        })
    }
    
    func userID() -> String {
        return Auth.auth().currentUser!.uid;
    }
    
    private func handleErrors(err: NSError , loginHandler: LoginHandler?) {
        
        if let errCode = AuthErrorCode(rawValue: err.code) {
            
            switch errCode {
                
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL)
                    break;
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD)
                break;
            case .userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND)
                    break;
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE)
                    break;
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PAASOWORD)
                    break;
                
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING)
                break;
        
            }
        }
    }//handleErrors
    
    func isLogOut() -> Bool {
        if Auth.auth().currentUser?.uid != nil {
            return true
        }
        return false
        
    } // isLogOut
    
    
    
    func logOut() -> Bool {
        
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                return true
            } catch {
                return false
            }
        }
        return true
    } // logOut
    
    
}



















