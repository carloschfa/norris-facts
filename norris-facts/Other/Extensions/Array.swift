//
//  Array.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

enum SerializationError: Error {
  case badInput
}
/**
Extension on `Array` that adds different helper methods such as JSON `Data` serialization
*/
public extension Array where Element: Any {
  /**
  Heper method that serializes the `Array` to JSON `Data`
  
  - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
  */
  func toJsonData() -> (data: Data?, error: Error?) {
    do {
      if (self[0] as? String == "bad input") { throw SerializationError.badInput }
      return (data: try JSONSerialization.data(withJSONObject: self, options: []), error: nil)
    } catch {
      return (data: nil, error: error)
    }
  }
}
