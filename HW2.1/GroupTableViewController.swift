//
//  GroupTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 06.01.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    let groups = [
    Group(groupID: "1", groupName: "group1", groupIcon: "groupIcon"),
    Group(groupID: "2", groupName: "group2", groupIcon: "groupIcon"),
    Group(groupID: "3", groupName: "group3", groupIcon: "groupIcon")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroupTableViewCell{
            cell.groupLabel.text = groups[indexPath.row].groupName
            cell.groupImage.image = UIImage(named:groups[indexPath.row].groupIcon)
            
            return cell
        }
        
        return UITableViewCell()

    }
    
}
