//
//  String+Extension.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

extension String {
  func pluralize(count: Int, prefix: String = "a", suffix: String = "s") -> String {
    return count == 1 ? (prefix + " " + self) : ("\(count) " + self + suffix)
  }
}
