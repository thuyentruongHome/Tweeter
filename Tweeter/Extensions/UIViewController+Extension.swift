//
//  UIViewController+Extension.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import UIKit

extension UIViewController {
  // MARK: - Alert
  func showInformedAlert(withTitle title: String, message: String) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: Constant.Alert.Action.ok, style: .default, handler: nil))
    present(alertView, animated: true, completion: nil)
  }

  func showConfirmationAlert(withTitle title: String, message: String, onAgreed: @escaping (() -> Void)) {
    let confirmationView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    confirmationView.addAction(UIAlertAction(title: Constant.Alert.Action.cancel, style: .default, handler: nil))
    confirmationView.addAction(UIAlertAction(title: Constant.Alert.Action.delete, style: .destructive, handler: { (_) in onAgreed() }))
    present(confirmationView, animated: true, completion: nil)
  }
}
