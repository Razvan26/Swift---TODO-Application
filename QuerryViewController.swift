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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryFirebase()
        // Do any additional setup after loading the view.
    }
    
    func setDatabase () {
        let userid = Auth.auth().currentUser?.uid ?? ""
//        let time = NSDate().timeIntervalSince1970
        let id = "title"
        print(id)
        database.child(userid).childByAutoId().setValue([id: "Make a big application  for money"])
        
    }
    func queryFirebase () {
         let userid = Auth.auth().currentUser?.uid ?? ""
        database.child(userid).observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var title = value?["title"] as? [String] ?? [""]
            print(title)
            
            for tit in value! {
                print(tit.value)
                let val = tit.value as? NSDictionary
                print(val?["title"] as? String ?? "")
                title.append(val?["title"] as? String ?? "")
            }
            print("This is title : ", title)
            let vcc = TODODisplayTableViewController() as TODODisplayTableViewController
            vcc.data = title
            let vc = UINavigationController(rootViewController: vcc)
            
            self.present(vc, animated: true)
        }
    }
}
