
//
//  ApiFactsGatewayCoreData.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 3/9/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ApiFactsGatewayCoreData {
  
  private struct Entities {
    static let Facts: String = "Facts"
    static let Categories: String = "Categories"
  }
  
  private let appDelegate: AppDelegate
  private let managedContext: NSManagedObjectContext
  private let facts: NSEntityDescription
  private let categories: NSEntityDescription
  
  init(appDelegate: AppDelegate, managedContext: NSManagedObjectContext) {
    self.appDelegate = appDelegate
    self.managedContext = managedContext
    self.facts = NSEntityDescription.entity(forEntityName: Entities.Facts, in: self.managedContext)!
    self.categories = NSEntityDescription.entity(forEntityName: Entities.Categories, in: self.managedContext)!
  }
  
  
}
