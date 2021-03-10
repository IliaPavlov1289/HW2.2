//
//  FrendTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 08.01.2021.
//

import UIKit
import RealmSwift

class FriendTableViewController: UITableViewController {

    var sections:[String] = []

    var friends: [User]? {
        let friends: Results<User>? = RealmManager.shared?.getObjects()
        return Array(friends!)
    }
    
    
    var filteredFriends:[User]? = []
    
    //var filteredFriends: Results<User>? { return friends }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "VKTableViewCell", bundle: nil), forCellReuseIdentifier: "VKCell")



        tableView.register(UINib(nibName: "SearchHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchHeader")

            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchHeader") as? SearchHeader {
                tableView.tableHeaderView = header
                header.searchBar.delegate = self
            }

        tableView.rowHeight = 60

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let token = Session.shared.token
        
        NetworkManager.loadUserFriends(token: token) { [weak self] (Users) in
            
//            self?.friends = Users
            
            try? RealmManager.shared?.add(objects: Users)
            self?.filteredFriends = self?.friends ?? []
            self?.sections = self?.createHeaderSections() ?? []
            
            self?.tableView.reloadData()
        }

    }
    
    func createHeaderSections() -> [String] {
        var sections:[String] = []
        
        for friend in filteredFriends ?? [] {
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
        let friendsInSection = filteredFriends?.filter{$0.userName.prefix(1) == sections[section]}
        return friendsInSection?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VKCell", for: indexPath) as? VKTableViewCell{
            let friendsInSection = filteredFriends?.filter{$0.userName.prefix(1) == sections[indexPath.section]}
            cell.cellId = friendsInSection?[indexPath.row].userID ?? 0
            cell.cellVKLabel.text = (friendsInSection?[indexPath.row].userName ?? "") + " " + (friendsInSection?[indexPath.row].userLastName ?? "")
            cell.downLoadImage(from: friendsInSection?[indexPath.row].userIcon ?? "")


            return cell
        }

        return UITableViewCell()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            if segue.identifier == "showPhotoCollection"{

                if let indexPath = self.tableView.indexPathForSelectedRow {

                let cell: VKTableViewCell? = tableView.cellForRow(at: indexPath) as? VKTableViewCell

                let friendPhotoCollection: FriendPhotoCollectionViewController = segue.destination as! FriendPhotoCollectionViewController

                    friendPhotoCollection.userID = cell?.cellId ?? 0

            }
        }
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:"showPhotoCollection", sender: nil)
    }
    

}

extension FriendTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText == "" {
                filteredFriends = friends
            } else {
                filteredFriends? = friends?.filter { (friend) -> Bool in
            return friend.userName.contains(searchText)
                } ?? []
       }
        sections = createHeaderSections()

        tableView.reloadData()
    }


}
