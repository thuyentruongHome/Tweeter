//
//  CreateTweetViewController.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController {

  // MARK: - Properties
  @IBOutlet weak var userAvatar: UIImageView!
  @IBOutlet weak var tweetMessageInput: UITextView!
  @IBOutlet weak var sendBtn: UIButton!
  @IBOutlet weak var bottomTextViewConstraint: NSLayoutConstraint!

  weak var keyboardNotification: NSObjectProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()

    tweetMessageInput.becomeFirstResponder()
    loadData()
  }

  // MARK: - Handlers
  @IBAction func cancelCreateTweet(_ sender: UIButton) {
    tweetMessageInput.resignFirstResponder()
    dismiss(animated: true, completion: nil)
  }

  @IBAction func sendTweet(_ sender: UIButton) {
    tweetMessageInput.resignFirstResponder()
    // TODO: create Tweet
    dismiss(animated: true, completion: nil)
  }

  // MARK: - Setup Data
  private func loadData() {
    userAvatar.image = User.current.avatarImage()
  }
}

// MARK: - UITextViewDelegate
extension CreateTweetViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    sendBtn.isEnabled = textView.text != ""
  }
}

// MARK: - Register/Remove Notifications
extension CreateTweetViewController {
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Register keyboardWillShowNotification to make sure textview is not under keyboard
    keyboardNotification = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: keyboardWillBeShow(notification:))
  }

  private func keyboardWillBeShow(notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    bottomTextViewConstraint.constant = keyboardSize.height
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    // Remove Notifications
    if let keyboardNotification = keyboardNotification {
      NotificationCenter.default.removeObserver(keyboardNotification)
    }
  }
}
