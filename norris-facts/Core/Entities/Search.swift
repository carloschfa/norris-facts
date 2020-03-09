//
//  Search.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 3/9/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import CoreData

struct Search {
  
  private struct Keys {
    static let Value: String = "value"
    static let SearchedAt: String = "url"
  }
  
  var value: String
  var searchedAt: Date
  
  init(value: String, searchedAt: Date) {
    self.value = value
    self.searchedAt = searchedAt
  }
  
  init(from data: NSManagedObject) {
    guard
      let value = data.value(forKey: Keys.Value) as? String,
      let searchedAt = data.value(forKey: Keys.SearchedAt) as? Date
      else { fatalError("Error during initialization.") }
    
    self.value = value
    self.searchedAt = searchedAt
  }
  
}
