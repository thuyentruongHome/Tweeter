//
//  TweetSpec.swift
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

class TweetSpec: QuickSpec {
  override func spec() {
    super.spec()

    var tweet: Tweet!
    let message = Faker().lorem.sentences()
    let user = User(name: Faker().name.name(), username: Faker().internet.username(), userAvatarUrl: Faker().lorem.word())
    tweet = Tweet(message: message, user: user)

    describe(".asDictionaryForNewTweet") {
      it("returns correct dictionary") {
        let returns_data = try! tweet.asDictionaryForNewTweet()
        expect(returns_data.keys.count) == 3
        let returns_user_data = returns_data["user"] as! [String : Any]
        expect((returns_user_data["name"] as! String)) == user.name
        expect((returns_user_data["username"] as! String)) == user.username
        expect((returns_data["message"] as! String)) == message
        expect((returns_data["created_at"] as! Date).userFriendlyFullDate()) == Date().userFriendlyFullDate()
        }
    }
  }
}
