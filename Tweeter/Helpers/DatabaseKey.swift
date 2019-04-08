//
//  DatabaseKey.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

struct DatabaseKey {
  struct Tweet {
    static let collectionName = "tweets"
    static let tweetId = "tweet_id"
    static let createdAt = "created_at"
  }
}
