//
//  ViewController.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var tweetTableView: UITableView!
  @IBOutlet weak var newTweetNotify: UIButton!

  let reuseIdentifier = "tweetCell"
  var tweets = [Tweet]()
  private var newTweets = [Tweet]()
  private var addedNewTweetIds = [String]()
  private let newTweetMockTime = Date()
  private let YLimitForLoadNewTweets: CGFloat = 50
  private let newTweetNotifyDuration = 5.0

  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()

    loadTweets()
  }

  // MARK: - Setup View Cycle
  // - setup/remove Observer New Tweets
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    TweetService.shared.setObserverNewTweets(with: newTweetMockTime)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    TweetService.shared.currentListener?.remove()
  }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension TweetsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
    cell.tweet = tweets[indexPath.row]
    return cell
  }

  // MARK: - Handlers for loading new Tweet
  // when user click NewTweetNotify
  @IBAction func clickNewTweetNotify(_ sender: UIButton) {
    tweetTableView.setContentOffset(.zero, animated: true) // move to top of tableView
  }

  // when tweet table is on top: user scroll tableView manually or after we scroll it to top
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == tweetTableView && tweetTableView.contentOffset.y < YLimitForLoadNewTweets {
      // we delay 0.2 to make sure we only load more tweets when move to top programmatically action finishs
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        self.loadNewTweets()
      }
    }
  }
}

//MARK: - NewTweetHandlerProtocol
extension TweetsViewController: NewTweetHandlerProtocol {
  func handleNewTweets(_ tweets: [Tweet]) {
    tweets.forEach { (tweet) in
      if !addedNewTweetIds.contains(tweet.tweetId!) {
        newTweets.insert(tweet, at: 0)
        addedNewTweetIds.insert(tweet.tweetId!, at: 0)
        notifyNewTweet()
      }
    }
  }
}

// MARK: - Setup Data
extension TweetsViewController {
  // loads Tweets data from server
  fileprivate func loadTweets() {
    TweetService.shared.fetchTweets { [weak self] (tweets, error) in
      guard let self = self else { return }

      if let error = error {
        DispatchQueue.main.async {
          self.showInformedAlert(withTitle: Constant.Alert.Title.error, message: error.localizedDescription)
        }
        return
      }

      if let tweets = tweets {
        self.tweets = tweets
        self.tweetTableView.reloadData()
        TweetService.shared.delegate = self
      }
    }
  }

  /*
   when user is on the top of tweets TableView, loads new tweets right away
   otherwhile (user is scrolling at the bottom), only shows `new tweet` notify which appear in specific duration
   */
  fileprivate func notifyNewTweet() {
    let firstIndexpath = IndexPath(row: 0, section: 0)
    if tweets.count == 0 || tweetTableView.indexPathsForVisibleRows?.contains(firstIndexpath) ?? false {
      loadNewTweets()
    } else if newTweetNotify.isHidden {
      newTweetNotify.isHidden = false
      newTweetNotify.pulsate()
      DispatchQueue.main.asyncAfter(deadline: .now() + newTweetNotifyDuration) {
        self.newTweetNotify.isHidden = true
      }
    }
  }

  // inserts new tweets on the top of tweets tableView
  fileprivate func loadNewTweets() {
    newTweetNotify.isHidden = true
    guard newTweets.count > 0 else { return }
    let newTweetsCopy = newTweets; newTweets.removeAll()
    tweets = newTweetsCopy + tweets
    let newIndexPaths = (0..<newTweetsCopy.count).map({ IndexPath(row: $0, section: 0)})
    tweetTableView.insertRows(at: newIndexPaths, with: .fade)
  }
}
