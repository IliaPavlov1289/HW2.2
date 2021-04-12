//
//  NewsTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 21.01.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news: [NewsPost] = []
    var users: [User] = []
    var groups: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let token = Session.shared.token
        
        NetworkManager.loadNewsPost(token: token) { [weak self] (NewsPostes, User, Group) in
            DispatchQueue.main.async {
            self?.news = NewsPostes
            self?.users = User
            self?.groups = Group
                print(self?.groups.count)
            
            self?.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as? NewsTableViewCell{
            let photoUrl = news[indexPath.row].attachments?.first?.photo?.sizes[3].url
            let id = news[indexPath.row].senderID
            if id > 0 {
                let index = users.firstIndex{$0.userID == id} ?? 0
                cell.senderIconImage.downloadImage(from: users[index].userIcon )
                cell.senderNameLabel.text = users[index].userName
            } else {
                let index = groups.firstIndex{$0.groupID == -id} ?? 0
                cell.senderIconImage.downloadImage(from: groups[index].groupIcon )
                cell.senderNameLabel.text = groups[index].groupName
            }
//            cell.senderIconImage.image = UIImage(named: news[indexPath.row].senderIcon)
//            cell.senderNameLabel.text = news[indexPath.row].senderName
            cell.newsTextLabel.text = news[indexPath.row].text
            cell.newsImage.downloadImage(from: photoUrl ?? "")
            cell.likeControl.countLike = news[indexPath.row].likes?.count ?? 0
            cell.commentControl.countComments = news[indexPath.row].comments?.count ?? 0
            cell.repostControl.countRepost = news[indexPath.row].reposts?.count ?? 0
            cell.viewsControl.countView = news[indexPath.row].views?.count ?? 0
            cell.selectionStyle = .none

            return cell
        }

        return UITableViewCell()

    }

}
