//
//  TODODisplayTableViewController.swift
//  TODOList
//
//  Created by Razvan26 on 28/01/2019.
//  Copyright © 2019 Razvan26. All rights reserved.
//


import UIKit
import FirebaseDatabase
import FirebaseAuth
import UserNotifications

let cellID = "cellIDTodo"

// MARK: - Table view cell setup

class TODODispayTableClass: UITableViewCell {
    
    let titleText : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont().myFont(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let isImportantText : UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont().myFont(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
   
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
        
        self.addSubview(titleText)
        self.addSubview(isImportantText)
        
        titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        isImportantText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        isImportantText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        isImportantText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class TODODisplayTableViewController: UITableViewController  {
    
    var data = ["This is your todo application, have fun!"]
    
    var parrentData = [""]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TODODispayTableClass.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 120
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTodo))
        data.remove(at: 0)
        parrentData.remove(at: 0)
        
        self.title = "Your TODO list"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TODODispayTableClass
        
        cell.titleText.text = data[indexPath.row]
        cell.isImportantText.text = "Text is very important for you!"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let datab = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            print("Delete Action Tapped")
            print(self.parrentData[indexPath.row])
            
            if (indexPath.row != 0) {
                self.data.remove(at: indexPath.row)
                datab.child(uid!).child(self.parrentData[indexPath.row]).removeValue()
                tableView.reloadData()
            }
            
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        
        
        return configuration
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        let notificationAction = UIContextualAction(style: .normal, title: "Remember me in one hour") { (action, view, handler) in
            print("Notify")
            print(self.parrentData[indexPath.row])
            
            let center = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            
            content.title = "From your TODO List application"
            
            content.body = "You have one task to complete..."
            
            content.body = "Your Task is : \(self.data[indexPath.row])"
            
            content.threadIdentifier = "notication-action-home"
            
            content.sound = UNNotificationSound.defaultCritical
            
            let data = Date(timeIntervalSinceNow: 3600)
            
            let dataComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: data)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponent, repeats: false)
            
            let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
            
            center.add(request) { (err) in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                }
            }
            
        }
        notificationAction.backgroundColor = .blue
        
        
        
        let configuration = UISwipeActionsConfiguration(actions: [notificationAction])
        
        
        
        return configuration
    }
    @objc func addTodo () {
        self.navigationController?.pushViewController(AddViewController(), animated: true)
    }
}
