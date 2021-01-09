//
//  FrendTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    let friends = [
    User(userID: "1", userName: "userName1", userIcon: "userIcon1"),
    User(userID: "2", userName: "userName2", userIcon: "userIcon2"),
    User(userID: "3", userName: "userName3", userIcon: "userIcon3")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendTableViewCell{
            cell.friendNameLabel.text = friends[indexPath.row].userName
            cell.friendFotoIconImage.image = UIImage(named:friends[indexPath.row].userIcon)
            
            return cell
        }
        
        return UITableViewCell()

    }
    
}
