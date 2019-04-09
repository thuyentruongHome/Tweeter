//
//  Tweet.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

struct Tweet: Codable {
  var tweetId: String?
  var message: String
  var user: User
  var createdAt: Date

  private enum CodingKeys: String, CodingKey {
    case tweetId = "tweet_id"
    case message, user
    case createdAt = "created_at"
  }

  init(message: String, user: User) {
    self.message = message
    self.user = user
    self.createdAt = Date()
  }

  func asDictionaryForNewTweet() throws -> [String: Any] {
    let encodedData = try JSONEncoder().encode(self)
    var data = try JSONSerialization.jsonObject(with: encodedData, options: []) as! [String: Any]
    data[DatabaseKey.Tweet.createdAt] = Date()
    return data
  }
}
