//
//  API.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation
import Firebase

protocol TweetServiceProtocol {
  func fetchTweets(completion: @escaping API.TweetsHandler)
  func sendTweet(_ tweet: Tweet, completion: @escaping API.ErrorHandler)
  func setObserverNewTweets(with newTweetMockTime: Date)
}

protocol NewTweetHandlerProtocol {
  func handleNewTweets(_ tweets: [Tweet])
}

class TweetService: TweetServiceProtocol {

  static let shared = TweetService()
  var tweetsCollectionRef: CollectionReference!
  var currentListener: ListenerRegistration?
  var delegate: NewTweetHandlerProtocol?

  init() {
    tweetsCollectionRef = Firestore.firestore().collection(DatabaseKey.Tweet.collectionName)
  }

  func fetchTweets(completion: @escaping API.TweetsHandler) {
    tweetsCollectionRef
      .order(by: DatabaseKey.Tweet.createdAt, descending: true)
      .getDocuments(completion: { (snapshot, error) in
        guard error == nil else { completion(nil, error); return }
        do {
          let tweets: [Tweet]? = try snapshot?.decoded()
          completion(tweets, nil)
        } catch let error {
          completion(nil, error)
        }
      })
  }

  func sendTweet(_ tweet: Tweet, completion: @escaping API.ErrorHandler) {
    var tweet = tweet
    tweet.tweetId = tweetsCollectionRef.document().documentID
    do {
      let data = try tweet.asDictionaryForNewTweet()
      tweetsCollectionRef.addDocument(data: data) { (error) in
        completion(error)
      }
    } catch let error {
      completion(error)
    }
  }

  func setObserverNewTweets(with newTweetMockTime: Date) {
    currentListener?.remove()
    currentListener = tweetsCollectionRef
      .whereField(DatabaseKey.Tweet.createdAt, isGreaterThan: newTweetMockTime)
      .order(by: DatabaseKey.Tweet.createdAt)
      .addSnapshotListener { [weak self] (snapshot, _) in
        do {
          if let tweets: [Tweet] = try snapshot?.decoded(), tweets.count > 0 {
            self?.delegate?.handleNewTweets(tweets)
          }
        } catch let error {
          print(error.localizedDescription)
        }
      }
  }
}
