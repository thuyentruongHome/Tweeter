//
//  TweetCell.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  // Mark: - Properties
  @IBOutlet weak var tweetUserImage: UIImageView!
  @IBOutlet weak var displayName: UILabel!
  @IBOutlet weak var tweetCreatedAt: UILabel!
  @IBOutlet weak var tweetMessage: UILabel!

  var tweet: Tweet? {
    didSet {
      loadData()
    }
  }

  fileprivate func loadData() {
    guard let tweet = tweet else { return }
    let user = tweet.user
    displayName.text = user.displayName()
    tweetCreatedAt.text = tweet.createdAt.timeAgoInWords()
    tweetMessage.text = tweet.message
    tweetUserImage.image = user.avatarImage()
  }
}
