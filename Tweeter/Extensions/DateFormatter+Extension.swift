//
//  Formatter.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

extension DateFormatter {
  static var firebaseDate: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter
  }()
}
