//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 27/11/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        OnTheMapClient.login(username: self.emailTextField.text ?? "" , password: self.passwordTextField.text ?? "" , completion: self.handleSessionResponse(success:error:))
        
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        setLoggingIn(true)
        
        if let url = URL(string: "https://www.udacity.com/account/auth#!/signup"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
    }
    
    func handleSessionResponse(success: Bool, error:Error?){
        if success{
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
        else{
            showAlert(message:  error?.localizedDescription ?? "", title: "Login Failed")
        }
        
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
      loggingIn ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
   
    
}
extension UIViewController {
    func showAlert(message:String, title:String){
        let alertVC = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertVC, animated: true, completion: nil)
    }
}




