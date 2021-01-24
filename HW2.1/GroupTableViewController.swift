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
    
    var filteredGroups: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredGroups = groups
        tableView.rowHeight = 60
        tableView.register(UINib(nibName: "SearchHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchHeader")
        
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchHeader") as? SearchHeader {
                tableView.tableHeaderView = header
                header.searchBar.delegate = self
            }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroupTableViewCell{
            cell.groupLabel.text = filteredGroups[indexPath.row].groupName
            cell.groupImage.image = UIImage(named:filteredGroups[indexPath.row].groupIcon)
            
            return cell
        }
        
        return UITableViewCell()

    }
    
}

extension GroupTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText == "" {
                filteredGroups = groups
            } else {
                filteredGroups = groups.filter { (group) -> Bool in
            return group.groupName.contains(searchText)
            }
       }
        
        tableView.reloadData()
    }
    

}
