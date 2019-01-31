//
//  TODODisplayTableViewController.swift
//  TODOList
//
//  Created by Razvan26 on 28/01/2019.
//  Copyright © 2019 Razvan26. All rights reserved.
//

import UIKit

let cellID = "cellIDTodo"



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
        
//        isImportantText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 15).isActive = true
        isImportantText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        isImportantText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        isImportantText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class TODODisplayTableViewController: UITableViewController {
    
    var data = ["This is your todo application, have fun!"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TODODispayTableClass.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 120
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTodo))
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
    
    
    
    @objc func addTodo () {
        self.navigationController?.pushViewController(AddViewController(), animated: true)
    }
}
