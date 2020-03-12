//
//  Category.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 3/12/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import CoreData

struct Category {
  
  private struct Keys {
    static let Value: String = "value"
  }
  
  var value: String
  
  init(value: String) {
    self.value = value
  }
  
  init(from data: NSManagedObject) {
    guard
      let value = data.value(forKey: Keys.Value) as? String
      else { fatalError("Error during initialization.") }
    
    self.value = value
  }
  
}
