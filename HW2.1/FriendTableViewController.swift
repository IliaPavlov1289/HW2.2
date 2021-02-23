//
//  FrendTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    var sections:[String] = []

    let friends = [
    User(userID: "1", userName: "BuserName", userIcon: "user"),
    User(userID: "2", userName: "GuserName", userIcon: "user"),
    User(userID: "3", userName: "SuserName", userIcon: "user"),
    User(userID: "4", userName: "JuserName", userIcon: "user"),
    User(userID: "5", userName: "AuserName", userIcon: "user"),
    User(userID: "6", userName: "WuserName", userIcon: "user"),
    User(userID: "7", userName: "YuserName", userIcon: "user"),
    User(userID: "8", userName: "AuserName1", userIcon: "user"),
    User(userID: "9", userName: "JuserName1", userIcon: "user"),
    User(userID: "10", userName: "EuserName", userIcon: "user"),
    User(userID: "11", userName: "OuserName", userIcon: "user"),
    User(userID: "12", userName: "WuserName1", userIcon: "user")
    ]
    var filteredFriends:[User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        filteredFriends = friends
        sections = createHeaderSections()
        
        tableView.register(UINib(nibName: "SearchHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchHeader")
        
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchHeader") as? SearchHeader {
                tableView.tableHeaderView = header
                header.searchBar.delegate = self
            }
        
        tableView.rowHeight = 60
        
    }

    func createHeaderSections() -> [String] {
        var sections:[String] = []
        for friend in filteredFriends {
            let firstSymbol = friend.userName.prefix(1)
            if sections.contains(String(firstSymbol)) { continue }
            sections.append(String(firstSymbol))
        }
        sections.sort(by: <)
        return sections
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = UIColor.blue.withAlphaComponent(0.1)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendsInSection = filteredFriends.filter{$0.userName.prefix(1) == sections[section]}
        return friendsInSection.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendTableViewCell{
            let friendsInSection = filteredFriends.filter{$0.userName.prefix(1) == sections[indexPath.section]}
            cell.friendNameLabel.text = friendsInSection[indexPath.row].userName
            cell.friendFotoIconImage.image = UIImage(named:friendsInSection[indexPath.row].userIcon)

            
            return cell
        }
        
        return UITableViewCell()

    }

}

extension FriendTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText == "" {
                filteredFriends = friends
            } else {
            filteredFriends = friends.filter { (friend) -> Bool in
            return friend.userName.contains(searchText)
            }
       }
        sections = createHeaderSections()
        
        tableView.reloadData()
    }
    

}
