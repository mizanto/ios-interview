//
//  TweetsViewController.swift
//  iOS interview Project
//
//  Created by Sergei Bendak on 11.05.2020.
//  Copyright © 2020 ExperimentX. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 99
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        
        let url = URL(string: "https://api.jsonbin.io/b/5eb9a2cd47a2266b1476cb8f")!
        let dataTask = URLSession.shared.dataTask(with: url) { (data, responsse, error) in
            guard let data = data else {
                return
            }
            
            do {
                self.tweets = try JSONDecoder().decode([Tweet].self, from: data)
            } catch {
                print(error)
                self.tweets = []
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        let url = URL(string: tweet.avatar)!
        let data = try? Data(contentsOf: url)
        cell.avatarImageView.image = UIImage(data: data!)
        cell.nameLabel.text = tweet.name
        cell.tweetLabel.text = tweet.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: tweet.date)!
        
        let cellFormatter = DateFormatter()
        cellFormatter.dateFormat = "hh:mm dd MMM YYYY"
        
        cell.dateLabel.text = cellFormatter.string(from: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

