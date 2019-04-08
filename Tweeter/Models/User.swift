//
//  User.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

struct User: Decodable {
  let username: String
  let usertag: String
  let userAvatarUrl: String
}
