//
//  Tweet.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
  var tweetId: String?
  var message: String
  var user: User
  var createdAt: Date

  private enum CodingKeys: String, CodingKey {
    case tweetId = "tweet_id"
    case message, user
    case createdAt = "created_at"
  }
}
