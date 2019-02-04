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
        textfield.placeholder = "Enter here your email address "
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocorrectionType = .no
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont().myFont(20)
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    let passwordTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter here your password "
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        textfield.autocapitalizationType = .none
        textfield.font = UIFont().myFont(20)
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let signInButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("Connect", for: UIControl.State.normal)
        button.setTitle("Loading", for: UIControl.State.highlighted)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont().myFont(30)
        button.setTitleShadowColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor.blue
        
        button.addTarget(self, action: #selector(signIn), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let registerButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("Create account", for: UIControl.State.normal)
        button.setTitle("Loading", for: UIControl.State.highlighted)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont().myFont(30)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(registerTouchUpInside), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    fileprivate func layoutSetup() {
        view.backgroundColor = UIColor.white
        
        self.title = "Sign In / Create account "
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(registerButton)
        self.view.addSubview(signInButton)
        
        emailTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 62).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 62).isActive = true
        

        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        registerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
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
                    let showWrontAlert = UIAlertController(title: "Create account", message: message, preferredStyle: UIAlertController.Style.alert)
                    showWrontAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(showWrontAlert, animated: true)
                    return
                }
                print("Works!")
                
                
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
                    let showWrontAlert = UIAlertController(title: "Sign In", message: message, preferredStyle: UIAlertController.Style.alert)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("End editing : Down!")
        self.view.endEditing(true)
    }
}
