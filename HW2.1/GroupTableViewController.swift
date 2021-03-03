//
//  GroupTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 06.01.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {

    var groups: [Group]?

    var filteredGroups: [Group]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredGroups = groups

        tableView.register(UINib(nibName: "VKTableViewCell", bundle: nil), forCellReuseIdentifier: "VKCell")
    
        tableView.rowHeight = 60
        tableView.register(UINib(nibName: "SearchHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchHeader")

            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchHeader") as? SearchHeader {
                tableView.tableHeaderView = header
                header.searchBar.delegate = self
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VKCell", for: indexPath) as? VKTableViewCell{
            cell.cellVKLabel?.text = filteredGroups?[indexPath.row].groupName
            cell.downLoadImage(from: filteredGroups?[indexPath.row].groupIcon ?? "")
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
                filteredGroups? = groups?.filter { (group) -> Bool in
            return group.groupName.contains(searchText)
                } ?? []
       }

        tableView.reloadData()
    }


}

