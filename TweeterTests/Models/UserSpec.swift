//
//  UserSpec.swift
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

class UserSpec: QuickSpec {
  override func spec() {
    super.spec()

    var name: String!
    var username: String!
    var userAvatarUrl: String!
    var _user: User?
    var user: User {
      guard _user == nil else { return _user! }
      _user = User(name: name, username: username, userAvatarUrl: userAvatarUrl)
      return _user!
    }

    beforeEach {
      name = Faker().name.name()
      username = Faker().internet.username()
      userAvatarUrl = Faker().lorem.word()
    }

    afterEach {
      _user = nil
    }

    describe(".displayName") {
      it("returns correct displayName") {
        expect(user.displayName()) == "\(name!) • @\(username!)"
      }
    }

    describe(".avatarImage()") {
      context("exists UIImage with username as image name") {
        beforeEach {
          userAvatarUrl = "tazanna"
        }

        it("returns user image") {
          expect(user.avatarImage()) == UIImage(named: userAvatarUrl!)
        }
      }

      context("does not exist UIImage with username as image name") {
        it("returns default avatar") {
          expect(user.avatarImage()) == UIImage(named: "default-avatar")
        }
      }
    }
  }
}
