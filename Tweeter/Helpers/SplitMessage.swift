//
//  SplitSentence.swift
//  Tweeter
//
//  Created by Macintosh on 4/9/19.
//  Copyright © 2019 thuyentruong. All rights reserved.
//

import Foundation

class SplitMessageSupport {
  var numberOfPartsLength: Int!
  var charLimit: Int!
  let firstIndicatorLength = 4 // part indicator ("1/2 ") when number of parts from 2...9
  let additionIndicatorLength = 2 // addition part indicator length is 2 with lower indicator - ("01/10 ") with ("1/2 ")

  var pattern: String {
    let charLimitIncludeIndicator = charLimit - firstIndicatorLength - additionIndicatorLength * (numberOfPartsLength - 1)
    return ".{1,\(charLimitIncludeIndicator)}(\\s|$)"
  }

  var regex: NSRegularExpression {
    return try! NSRegularExpression(pattern: pattern, options: [])
  }

  init(charLimit: Int) {
    self.charLimit = charLimit
  }

  /*
   With part indicator:
      when numberOfParts: 2...9 => 1/2/.../9
      when numberOfParts: 10..99 => 01/02/.../99
   */
  func makePartIndicator(for text: String, part: Int, numberOfParts: Int) -> String {
    let numberOfChars = String(numberOfParts).count
    let partIndicator = String(format: "%0\(numberOfChars)d", part)
    return "\(partIndicator)/\(numberOfParts) \(text)"
  }
}

let defaultCharLimit = 50 // By default, 50 characters

func splitMessage(_ text: String, charLimit: Int = defaultCharLimit) throws -> [String] {
  // If text is less than or equal to charLimit (default: 50) characters, return it as is.
  if text.count <= charLimit { return [text] }

  // Handlers for text is more than charLimit (50) characters
  let support = SplitMessageSupport(charLimit: charLimit)
  var numberOfPartsLength = 1 // purpose is to define length of part indicator
  var numberOfParts: Int!
  var textResults: [NSTextCheckingResult]!
  repeat {
    support.numberOfPartsLength = numberOfPartsLength
    textResults = support.regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
    numberOfParts = textResults.count
    numberOfPartsLength = String(numberOfParts).count
  } while numberOfPartsLength != support.numberOfPartsLength

  var partRanges = [(startIndex: Int, endIndex: Int)]() // stores ranges of splitted parts
  for (index, result) in textResults.enumerated() {
    let startIndex = partRanges.count == 0 ? 0 : (partRanges[index - 1].endIndex + 2) // move 2 indexes with separator & first character
    // If the message contains a span of non-whitespace characters longer than 50 characters, display an error.
    guard startIndex == result.range.lowerBound else {
      throw NSError(domain: Constant.domain,
                    code: Constant.overLongMessageErrorCode,
                    userInfo: [NSLocalizedDescriptionKey: Constant.overLongMessageDescription])
    }
    var endIndex = result.range.upperBound - 1 // -1 for seemly upperBound returns end as in CountableRange (a..<b)
    if index != textResults.count - 1 { endIndex -= 1 } // remove whitespace separator as split
    partRanges.append((startIndex, endIndex))
  }

  var splittedMessages = [String]()
  for (index, partRange) in partRanges.enumerated() {
    let splittedMessage = text[partRange.startIndex...partRange.endIndex]
    let splittedMessageWithIndicator = support.makePartIndicator(for: splittedMessage, part: index + 1, numberOfParts: numberOfParts)
    splittedMessages.append(splittedMessageWithIndicator)
  }
  return splittedMessages
}
