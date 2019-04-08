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

struct TimeAgoLimit {
  static let monthsAboutYear = 3
  static let monthsOverYear = 9
  static let daysAboutMonth = 20
}

extension Date: Dateable {
  func userFriendlyFullDate() -> String {
    return DateFormatter.firebaseDate.string(from: self)
  }

  func timeAgoInWords(from: Date = Date()) -> String {
    let calendar = Calendar.current as NSCalendar
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .month, .year]
    let components = calendar.components(unitFlags, from: self, to: from, options: [])

    if let year = components.year, year > 0, let month = components.month {
      if month <= TimeAgoLimit.monthsAboutYear {
        return "about \("year".pluralize(count: year))"
      } else if month <= TimeAgoLimit.monthsOverYear {
        return "over \("year".pluralize(count: year))"
      } else {
        return "almost \("year".pluralize(count: year + 1))"
      }
    }

    if let month = components.month, month > 0 {
      if month >= TimeAgoLimit.monthsOverYear {
        return "about a year"
      } else {
        return "\("month".pluralize(count: month)) ago"
      }
    }

    if let day = components.day, day > 0 {
      if day > TimeAgoLimit.daysAboutMonth {
        return "about a month"
      } else {
        return "\("day".pluralize(count: day)) ago"
      }
    }

    if let hour = components.hour, hour > 0 {
      return "about \("hour".pluralize(count: hour)) ago"
    }

    if let minute = components.minute, minute > 0 {
      return "about \("minute".pluralize(count: minute)) ago"
    }

    if let second = components.second, second > 20 {
      return "less than a minute"
    }
    return "Just now"
  }
}
