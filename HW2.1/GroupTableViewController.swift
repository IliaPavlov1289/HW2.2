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
//        NetworkManager.loadUserGroups(token: Session.shared.token) { [weak self] groups in
//            self?.groups = groups
//            self?.tableView?.reloadData()
//        }
//        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "groupCell")
    
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "groooopCell")
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


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("11111111111122222222222")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "groooopCell", for: indexPath) as? GroupTableViewCell{
            cell.groupLabel?.text = filteredGroups?[indexPath.row].groupName
            print(cell.groupLabel?.text)
            print(filteredGroups?[indexPath.row].groupName)
          //  cell.groupImage?.image = UIImage(named:filteredGroups?[indexPath.row].groupIcon ?? "")
            return cell
        }

        print("000000000000000000000")
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

