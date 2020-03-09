//
//  Facts.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import CoreData

struct Fact {
  
  private struct Keys {
    static let Id: String = "id"
    static let Value: String = "value"
    static let Url: String = "url"
    static let Categories: String = "categories"
  }
  
  var id: String
  var value: String
  var url: String
  var categories: [String]
  
  init(id: String, value: String, url: String, categories: [String]) {
    self.id = id
    self.value = value
    self.url = url
    self.categories = categories
  }
  
  init(from data: NSManagedObject) {
    guard
      let id = data.value(forKey: Keys.Id) as? String,
      let value = data.value(forKey: Keys.Value) as? String,
      let url = data.value(forKey: Keys.Url) as? String,
      let categories = data.value(forKey: Keys.Categories) as? String
      else { fatalError("Error during initialization.") }
    
    self.id = id
    self.value = value
    self.url = url
    self.categories = [categories]
  }
  
}
