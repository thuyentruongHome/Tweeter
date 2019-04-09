//
//  SplitMessageSpec.swift
//  TweeterTests
//
//  Created by Macintosh on 4/9/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Fakery

@testable import Tweeter

class SplitMessageSpec: QuickSpec {
  override func spec() {
    super.spec()

    var textSample: String!

    var splittedMessagesResult: [String] {
      return try! splitMessage(textSample)
    }

    describe("splitMessage") {
      context("message is less than 50 characters,", closure: {
        beforeEach { textSample = "This message is less than 50 characters." }
        it("returns entire message without part indicator") {
          expect(splittedMessagesResult) == [textSample]
        }
      })

      context("message is equal to 50 characters,", closure: {
        beforeEach { textSample = Faker().lorem.characters(amount: 50) }
        it("returns entire message without part indicator") {
          expect(splittedMessagesResult) == [textSample]
        }
      })

      context("message is more than 50 characters", closure: {
        context("expects split to 2 parts") {
          beforeEach {
            textSample = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
          }
          it("returns 2 correct split messages") {
            expect(splittedMessagesResult) == [
              "1/2 I can't believe Tweeter now supports chunking",
              "2/2 my messages, so I don't have to do it myself."
            ]
          }
        }

        context("expects split to 12 parts") {
          beforeEach {
            textSample = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. This is great feature I think, you should try it right away. Go!"
          }
          it("returns 11 correct split messages") {
            expect(try! splitMessage(textSample, charLimit: 22)) == [
              "01/11 I can't believe",
              "02/11 Tweeter now",
              "03/11 supports",
              "04/11 chunking my",
              "05/11 messages, so I",
              "06/11 don't have to do",
              "07/11 it myself. This",
              "08/11 is great feature",
              "09/11 I think, you",
              "10/11 should try it",
              "11/11 right away. Go!"
            ]
          }
        }
      })

      context("the message contains a span of non-whitespace characters longer than 50 characters,") {
        beforeEach { textSample = Faker().lorem.characters(amount: 51) }
        it("throws error") {
          expect { try splitMessage(textSample) }.to(throwError { (error: Error) in
            expect(error._domain) == "Tweeter"
            expect(error._code) == 1
            expect(error.localizedDescription) == "Your message contains a span of non-whitespace characters longer than 50 characters."
          })
        }
      }
    }
  }
}
