//
//  NewsTableViewController.swift
//  HW2.1
//
//  Created by Илья Павлов on 21.01.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let news = [
        News(senderIcon: "user", senderName: "Плутон", newsText: "Плуто́н - это планета!", newsImage: "Учёный"),
        News(senderIcon: "user", senderName: "Плутон", newsText: "Плуто́н (134340 Pluto) — крупнейшая известная карликовая планета Солнечной системы[11], транснептуновый объект и десятое по массе (без учёта спутников) небесное тело, обращающееся вокруг Солнца — после восьми планет и Эриды[12][13][14]. Первоначально Плутон считали девятой классической планетой, но сейчас он считается карликовой планетой и крупнейшим объектом пояса Койпера (в частности, крупнее Эриды)", newsImage: "Pluto"),
        News(senderIcon: "user", senderName: "Плутон", newsText: "Плуто́н (134340 Pluto) — крупнейшая известная карликовая планета Солнечной системы[11], транснептуновый объект и десятое по массе (без учёта спутников) небесное тело, обращающееся вокруг Солнца — после восьми планет и Эриды[12][13][14]. Первоначально Плутон считали девятой классической планетой, но сейчас он считается карликовой планетой и крупнейшим объектом пояса Койпера (в частности, крупнее Эриды)", newsImage: "Pluto")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as? NewsTableViewCell{
            cell.senderIconImage.image = UIImage(named: news[indexPath.row].senderIcon)
            cell.senderNameLabel.text = news[indexPath.row].senderName
            cell.newsTextLabel.text = news[indexPath.row].newsText
            cell.newsImage.image = UIImage(named: news[indexPath.row].newsImage)
            cell.selectionStyle = .none

            
            return cell
        }
        
        return UITableViewCell()

    }

}
