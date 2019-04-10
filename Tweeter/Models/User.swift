//
//  User.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import UIKit

struct User: Codable {
  let name: String
  var username: String
  let userAvatarUrl: String

  // For Sample purpose, replace when implemening authentication
  static let current: User = {
    return User(name: "Tazanna", username: "tazanna.net", userAvatarUrl: "tazanna")
  }()

  func displayName() -> String {
    return "\(name) • @\(username)"
  }

  func avatarImage() -> UIImage {
    return UIImage(named: userAvatarUrl) ?? UIImage(named: Constant.User.defaultAvatar)!
  }
}
