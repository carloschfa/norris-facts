//
//  Dictionary.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

/**
Extension on `Dictionary` that adds different helper methods such as JSON `Data` serialization
*/
public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
  
  /**
  Heper method that serializes the `Dictionary` to JSON `Data`
  
  - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
  */
        func toJsonData() -> Data {
    do {
      return try JSONSerialization.data(withJSONObject: self, options: [])
    } catch {
      return Data()
    }
  }
}
