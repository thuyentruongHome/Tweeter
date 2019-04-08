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
    let fromDate: Date = stringToDate(str: "08 Apr 2019 17:25:29 UTC")

    beforeEach {
      NSTimeZone.default = NSTimeZone(name: "Asia/Singapore")! as TimeZone
    }

    afterEach {
      NSTimeZone.default = cachedTimeZone
    }

    describe(".userFriendlyFullDate") {
      date = stringToDate(str: "02 Jan 2001 10:26:05 UTC") // Jan 02, 2001 10:26:05 UTC

      it("returns correct userFriendlyFullDate") {
        expect(date.userFriendlyFullDate()) == "2001-01-02 18:26:05 +0800"
      }
    }

    describe("timeAgoInWords") {
      context("date is about 3 years") {
        beforeEach { date = self.stringToDate(str: "01 Apr 2016 17:25:29 UTC") }
        it("returns about 3 years") {
          expect(date.timeAgoInWords(from: fromDate)) == "about 3 years"
        }
      }

      context("date is over 1 year") {
        beforeEach { date = self.stringToDate(str: "08 Aug 2017 17:25:29 UTC") }
        it("returns over a year") {
          expect(date.timeAgoInWords(from: fromDate)) == "over a year"
        }
      }

      context("date is almost 2 years") {
        beforeEach { date = self.stringToDate(str: "08 May 2017 17:25:29 UTC") }
        it("returns almost 2 years") {
          expect(date.timeAgoInWords(from: fromDate)) == "almost 2 years"
        }
      }

      context("date is about a year") {
        beforeEach { date = self.stringToDate(str: "07 Jun 2018 17:25:29 UTC") }
        it("returns about a year") {
          expect(date.timeAgoInWords(from: fromDate)) == "about a year"
        }
      }

      context("date is 6 months ago") {
        beforeEach { date = self.stringToDate(str: "06 Oct 2018 17:25:29 UTC") }
        it("returns 6 months ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "6 months ago"
        }
      }

      context("date is a month ago") {
        beforeEach { date = self.stringToDate(str: "06 Mar 2019 17:25:29 UTC") }
        it("returns a month ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "a month ago"
        }
      }

      context("date is about a month") {
        beforeEach { date = self.stringToDate(str: "18 Mar 2019 17:25:29 UTC") }
        it("returns about a month") {
          expect(date.timeAgoInWords(from: fromDate)) == "about a month"
        }
      }

      context("date is 9 days ago") {
        beforeEach { date = self.stringToDate(str: "30 Mar 2019 17:25:29 UTC") }
        it("returns 9 days ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "9 days ago"
        }
      }

      context("date is a day ago") {
        beforeEach { date = self.stringToDate(str: "07 Apr 2019 17:25:29 UTC") }
        it("returns a day ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "a day ago"
        }
      }

      context("date is about 20 hours ago") {
        beforeEach { date = self.stringToDate(str: "07 Apr 2019 21:25:29 UTC") }
        it("returns about 20 hours ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "about 20 hours ago"
        }
      }

      context("date is about a hour ago") {
        beforeEach { date = self.stringToDate(str: "08 Apr 2019 16:25:29 UTC") }
        it("returns about a hour ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "about a hour ago"
        }
      }

      context("date is about 45 minutes ago") {
        beforeEach { date = self.stringToDate(str: "08 Apr 2019 16:40:29 UTC") }
        it("returns about 45 minutes ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "about 45 minutes ago"
        }
      }

      context("date is about a minute ago") {
        beforeEach { date = self.stringToDate(str: "08 Apr 2019 17:24:29 UTC") }
        it("returns about a minute ago") {
          expect(date.timeAgoInWords(from: fromDate)) == "about a minute ago"
        }
      }

      context("date is less than a minute") {
        beforeEach { date = self.stringToDate(str: "08 Apr 2019 17:24:49 UTC") }
        it("returns less than a minute") {
          expect(date.timeAgoInWords(from: fromDate)) == "less than a minute"
        }
      }

      context("date is about 10 seconds") {
        beforeEach { date = self.stringToDate(str: "08 Apr 2019 17:25:19 UTC") }
        it("returns Just now") {
          expect(date.timeAgoInWords(from: fromDate)) == "Just now"
        }
      }
    }
  }

  fileprivate func stringToDate(str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss Z"
    return dateFormatter.date(from: str)!
  }
}
