//
//  MyTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 07.01.2021.
//

import UIKit

class MyGroupTableViewController: UITableViewController {
    
    var groups: [Group] = []

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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyGroupTableViewCell {
            cell.myGroupLabel.text = groups[indexPath.row].groupName
            cell.myGroupImage.image = UIImage(named:groups[indexPath.row].groupIcon)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindFromTableViewController(_ segue: UIStoryboardSegue){
        
        guard let tableViewController = segue.source as? GroupTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else {return}
        let group = tableViewController.groups[indexPath.row]
        
        if groups.filter({$0.groupID == group.groupID}).count > 0 {return}
        
        groups.append(group)
        tableView.reloadData()
    }

}
