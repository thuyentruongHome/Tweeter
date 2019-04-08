//
//  Date+ExtensionSpec.swift
//  TweeterTests
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Fakery

@testable import Tweeter

class DateExtensionSpec: QuickSpec {
  override func spec() {
    super.spec()

    let cachedTimeZone = NSTimeZone.default
    var date: Date!

    beforeEach {
      NSTimeZone.default = NSTimeZone(name: "Asia/Singapore")! as TimeZone
    }

    afterEach {
      NSTimeZone.default = cachedTimeZone
    }

    describe(".userFriendlyFullDate") {
      date = stringToDate(str: "02 Jan 2001 10:26:05 UTC") // Jan 02, 2001 10:26:05 UTC

      it("returns correct userFriendlyFullDate") {
        expect(date.userFriendlyFullDate()) == "2001-01-02 18:26:05"
      }
    }


  fileprivate func stringToDate(str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss Z"
    return dateFormatter.date(from: str)!
  }
}
