//
//  MyTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 07.01.2021.
//

import UIKit
import RealmSwift

class MyGroupTableViewController: UITableViewController {
    
    var groups: Results<Group>? {
        let groups: Results<Group>? = RealmManager.shared?.getObjects()
        return groups
    }

    
    var filteredGroups: Results<Group>? {
        return groups
    }
    
    private var filteredGroupsNotificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFiltredNitificationToken()

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
            print("11111111111111111111111111111")

//            self?.groups = Groups
            try? RealmManager.shared?.add(objects: Groups)
//            self?.filteredGroups = self?.groups

//            self?.tableView.reloadData()
        }
    }
    
    private func createFiltredNitificationToken() {
        filteredGroupsNotificationToken = filteredGroups?.observe { [weak self] change in
            switch change {
            case .initial(let groups):
                print("Initialize \(groups.count)")
                break
            case .update(let groups, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("""
                    New count \(groups.count)
                    Deletions \(deletions)
                    Insertions \(insertions)
                    Modifications \(modifications)
                    """
                    )
                
                self?.tableView.beginUpdates()
                
                let deletionIndexPaths = deletions.map { IndexPath(item: $0, section: 0) }
                let insertionsIndexPaths = insertions.map { IndexPath(item: $0, section: 0) }
                let modificationsIndexPaths = modifications.map { IndexPath(item: $0, section: 0) }
                
                self?.tableView.deleteRows(at: deletionIndexPaths, with: .automatic)
                self?.tableView.insertRows(at: insertionsIndexPaths, with: .automatic)
                self?.tableView.reloadRows(at: modificationsIndexPaths, with: .automatic)
                self?.tableView.endUpdates()
                
            case .error(let error):
                print (error.localizedDescription)
            }
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = filteredGroups?[indexPath.row] else {
//                filteredGroups?.remove(at: indexPath.row)
                return
            }
            
            if (try? RealmManager.shared?.delete(object: group)) != nil {
//                filteredGroups?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
            }
        }
    }
    
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
//            if searchText == "" {
//                filteredGroups = groups
//            } else {
//                filteredGroups? = groups?.filter { (group) -> Bool in
//            return group.groupName.contains(searchText)
//                } ?? []
//       }

        tableView.reloadData()
    }

}

