//
//  QuerryViewController.swift
//  TODOList
//
//  Created by Razvan26 on 30/01/2019.
//  Copyright © 2019 Razvan26. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class QuerryViewController: UIViewController {
    
    let database = Database.database().reference()
    
    fileprivate func activitySetup() {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        self.view.addSubview(activity)
        activity.startAnimating()
        activity.color = UIColor.white
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySetup()
        
        queryFirebase()
        // Do any additional setup after loading the view.
    }
    
    func queryFirebase () {
         let userid = Auth.auth().currentUser?.uid ?? ""
        database.child(userid).observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var title = value?["title"] as? [String] ?? [""]
            var time = value?["time"] as? [String] ?? [""]
            var keys = value?["key"] as? [String] ?? [""]
            print(title)
            
            for tit in value! {
                print(tit.value)
                let val = tit.value as? NSDictionary
                print(val?["title"] as? String ?? "")
                keys.append(tit.key as? String ?? "")
                title.append(val?["title"] as? String ?? "")
                time.append(val?["time"] as? String ?? "")
            }
            print("This is title : ", title)
            let vcc = TODODisplayTableViewController() as TODODisplayTableViewController
            vcc.data = title
            vcc.timeDate = time
            vcc.parrentData = keys
            let vc = UINavigationController(rootViewController: vcc)
            
            self.present(vc, animated: true)
        }
    }
}
