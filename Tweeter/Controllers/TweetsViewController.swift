//
//  ViewController.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var tweetTableView: UITableView!

  let reuseIdentifier = "tweetCell"
  var tweets = [Tweet]()

  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension TweetsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
    cell.tweet = tweets[indexPath.row]
    return cell
  }
}

