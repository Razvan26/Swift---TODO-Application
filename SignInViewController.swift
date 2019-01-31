//
//  SignInViewController.swift
//  TODOList
//
//  Created by Razvan26 on 28/01/2019.
//  Copyright © 2019 Razvan26. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    let auth = Auth.auth()
    
    
    
    let emailTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter here your  email address "
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    let passwordTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter here your  password "
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        textfield.autocapitalizationType = .none
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let signInButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("SignIn", for: UIControl.State.normal)
        button.setTitle("Loading", for: UIControl.State.highlighted)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleShadowColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(signIn), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let registerButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("Register", for: UIControl.State.normal)
        button.setTitle("Loading", for: UIControl.State.highlighted)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(registerTouchUpInside), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "SignIn / register "
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        self.view.addSubview(registerButton)
        
        emailTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 10).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 10).isActive = true
        
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor, constant: -(view.frame.width / 2.5)).isActive = true
    }
    
    @objc func registerTouchUpInside () {
        print("Register !")
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        if (emailText != "" && passwordText != "") {
            auth.createUser(withEmail: emailText, password: passwordText) { (res, err) in
                if (err != nil) {
                    print(err?.localizedDescription ?? "Error is big!")
                    let message = "Error : \(err?.localizedDescription ?? "")"
                    let showWrontAlert = UIAlertController(title: "Register", message: message, preferredStyle: UIAlertController.Style.alert)
                    showWrontAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(showWrontAlert, animated: true)
                    return
                }
                print("Works!")
//                let vc = UINavigationController(rootViewController: TODODisplayTableViewController())
                
                self.present(AddViewController(), animated: true)
            }
         
        }
        else {
            return
        }
    }
    @objc func signIn () {
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        if(emailText != "" && passwordText != "") {
            auth.signIn(withEmail: emailText, password: passwordText) { (res, err) in
                if (err != nil) {
                    let message = "Error : \(err?.localizedDescription ?? "")"
                    let showWrontAlert = UIAlertController(title: "Register", message: message, preferredStyle: UIAlertController.Style.alert)
                    showWrontAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(showWrontAlert, animated: true)
                    return
                }
                print("Works!")
                let vc = UINavigationController(rootViewController: QuerryViewController())
                
                self.present(vc, animated: true)
            }
        }
        else {
            let message = "Please complete all forms"
            let showWrontAlert = UIAlertController(title: "SignIn", message: message, preferredStyle: UIAlertController.Style.alert)
            showWrontAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(showWrontAlert, animated: true)
            return
        }
    }
}
