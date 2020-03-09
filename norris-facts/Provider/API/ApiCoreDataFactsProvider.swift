
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

class ApiCoreDataFactsProvider {
  
  private struct Entities {
    static let Facts: String = "Facts"
    static let Categories: String = "Categories"
  }
  
  private struct Keys {
    static let Id: String = "id"
    static let Value: String = "value"
    static let Url: String = "url"
    static let Categories: String = "categories"
  }
  
  private let appDelegate: AppDelegate
  private let managedContext: NSManagedObjectContext
  private let factsEntity: NSEntityDescription
  private let categoriesEntity: NSEntityDescription
  
  init(appDelegate: AppDelegate, managedContext: NSManagedObjectContext) {
    self.appDelegate = appDelegate
    self.managedContext = managedContext
    self.factsEntity = NSEntityDescription.entity(forEntityName: Entities.Facts, in: self.managedContext)!
    self.categoriesEntity = NSEntityDescription.entity(forEntityName: Entities.Categories, in: self.managedContext)!
  }
  
  func get() -> [Fact] {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.Facts)
    
    do {
      let fetchedResult = try managedContext.fetch(request)
      guard let result = fetchedResult as? [NSManagedObject] else { return [] }
      var facts: [Fact] = []
      for data in result {
        let fact = Fact(from: data)
        facts.append(fact)
      }
      return facts
    } catch let error {
      NSLog("\(error.localizedDescription)")
      return []
    }
  }
  
  func insert(fact: Fact) {
    
    if self.checkIfExists(using: Entities.Facts, where: Keys.Id, equals: fact.id) == false {
      let factObject = NSManagedObject(entity: factsEntity, insertInto: managedContext)
      factObject.setValue(fact.id, forKey: Keys.Id)
      factObject.setValue(fact.value, forKey: Keys.Value)
      factObject.setValue(fact.url, forKey: Keys.Url)
      factObject.setValue(fact.categories.first ?? "", forKey: Keys.Categories)
      
      do {
        try managedContext.save()
      } catch let error {
        NSLog("\(error.localizedDescription)")
      }
    }
  }
  
  func deleteAll(from entity: String) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let delete = NSBatchDeleteRequest(fetchRequest: request)
    
    do {
      try managedContext.execute(delete)
    } catch let error {
      NSLog("\(error.localizedDescription)")
    }
  }
  
  
  private func checkIfExists(using entity: String, where key: String, equals value: String) -> Bool {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let predicate = NSPredicate(format: "\(key) == %@", value)
    
    request.predicate = predicate
    request.fetchLimit = 1
    
    do {
      let count = try managedContext.count(for: request)
      return count == 0 ? false : true
    } catch let error {
      NSLog("\(error.localizedDescription)")
      return false
    }
  }
  
}
