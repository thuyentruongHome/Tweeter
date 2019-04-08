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
}
