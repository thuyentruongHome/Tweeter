//
//  Date+Extension.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

protocol Dateable {
  func userFriendlyFullDate() -> String
}

extension Date: Dateable {
  func userFriendlyFullDate() -> String {
    return DateFormatter.firebaseDate.string(from: self)
  }
}
