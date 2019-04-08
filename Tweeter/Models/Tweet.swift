//
//  Tweet.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
  let message: String
  let user: User
  let createdAt: Date

  private enum CodingKeys: String, CodingKey {
    case message, user
    case createdAt = "created_at"
  }
}
