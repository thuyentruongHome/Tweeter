//
//  Snapshot+Extension.swift
//  Tweeter
//
//  Created by Macintosh on 4/8/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
  func decoded<T: Decodable>() throws -> T {
    var dict = data()
    for (key, value) in dict {
      if let value = value as? Date {
        dict[key] = value.userFriendlyFullDate()
      }
    }
    let data = try JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.firebaseDate)
    return try jsonDecoder.decode(T.self, from: data)
  }
}

extension QuerySnapshot {
  func decoded<T: Decodable>() throws -> [T] {
    return try documents.map({ try $0.decoded() })
  }
}
