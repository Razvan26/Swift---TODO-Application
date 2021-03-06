//
//  AddViewController.swift
//  TODOList
//
//  Created by Razvan26 on 28/01/2019.
//  Copyright © 2019 Razvan26. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddViewController: UIViewController {
    
    let nameOfItem: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Add item into your TODO-List"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont().myFont(20)
        return textfield
    }()
    
    let confirmButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("Add item", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont().myFont(30)
        button.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        button.setTitle("Added!", for: UIControl.State.highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToDatabase), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor.blue
        return button
    }()
    
    
    fileprivate func layoutSetup() {
        view.backgroundColor = UIColor.white
        self.view.addSubview(nameOfItem)
        self.view.addSubview(confirmButton)
        
        nameOfItem.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nameOfItem.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        nameOfItem.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        confirmButton.topAnchor.constraint(equalTo: nameOfItem.bottomAnchor, constant: 20).isActive = true
        confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 60)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setDatabase (_ message: String) {
        
        let database = Database.database().reference()
        
        let userid = Auth.auth().currentUser?.uid ?? ""
        let id = "title"
        let date = Date()
        let calender = Calendar.current
        let tData = calender.dateComponents([.day, .hour, .second], from: date)
        let time = "time"
        
        print(date)
        
        print(id)
        database.child(userid).childByAutoId().setValue([id: message, time: "\(tData)"])
        
    }
    @objc func addToDatabase () {
        if (nameOfItem.text != "") {
            let titleMessage = nameOfItem.text!
            setDatabase(titleMessage)
            let vc = UINavigationController(rootViewController: QuerryViewController())
            self.present(vc, animated: true)
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
