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
      static let cancelCreateTweetConfirm = "You haven't sent your tweet."
    }

    struct Action {
      static let delete = "Delete"
      static let cancel = "Cancel"
      static let ok = "OK"
    }

    struct Message {
      static let cancelCreateTweetMessage = "Are you sure you want to delete your draft tweet?"
    }
  }

  struct User {
    static let defaultAvatar = "default-avatar"
  }
}
