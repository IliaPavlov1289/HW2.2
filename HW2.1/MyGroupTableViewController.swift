//
//  MyTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 07.01.2021.
//

import UIKit
import RealmSwift

class MyGroupTableViewController: UITableViewController {
    
    var groups: [Group]? {
        guard let groups: Results<Group> = RealmManager.shared?.getObjects()
        else { return [] }
        return Array(groups)
    }
    
    var filteredGroups: [Group]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        let token = Session.shared.token
        
        NetworkManager.loadUserGroups(token: token) { [weak self] (Groups) in

//            self?.groups = Groups
            try? RealmManager.shared?.add(objects: Groups)
            self?.filteredGroups = self?.groups ?? []
            
            self?.tableView.reloadData()
        }

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VKCell", for: indexPath) as? VKTableViewCell{
            cell.cellVKLabel?.text = filteredGroups?[indexPath.row].groupName ?? ""
            cell.downLoadImage(from: filteredGroups?[indexPath.row].groupIcon ?? "")
            return cell
        }
        
        return UITableViewCell()
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            groups?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
//    @IBAction func unwindFromTableViewController(_ segue: UIStoryboardSegue){
//
//        guard let tableViewController = segue.source as? GroupTableViewController,
//              let indexPath = tableViewController.tableView.indexPathForSelectedRow else {return}
//        let group = tableViewController.groups?[indexPath.row]
//
//        if groups?.filter({$0.groupID == group?.groupID}).count ?? 0 > 0 {return}
//
//        groups!.append(group!)
//        tableView.reloadData()
//    }
//
}

extension MyGroupTableViewController: UISearchBarDelegate {

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
