//
//  Constants.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

struct Constant {
  static let domain = "Tweeter"
  static let overLongMessageErrorCode = 1
  static let overLongMessageDescription = "Your message contains a span of non-whitespace characters longer than 50 characters."

  struct Alert {
    struct Title {
      static let error = "Error"
    }

    struct Action {
      static let ok = "OK"
    }
  }

  struct User {
    static let defaultAvatar = "default-avatar"
  }
}
