
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
    static let Searches: String = "Searches"
  }
  
  private struct Keys {
    static let Id: String = "id"
    static let Value: String = "value"
    static let Url: String = "url"
    static let Categories: String = "categories"
    static let SearchedAt: String = "searchedAt"
  }
  
  private let appDelegate: AppDelegate
  private let managedContext: NSManagedObjectContext
  private let factsEntity: NSEntityDescription
  private let searchesEntity: NSEntityDescription
  
  init(appDelegate: AppDelegate, managedContext: NSManagedObjectContext) {
    self.appDelegate = appDelegate
    self.managedContext = managedContext
    self.factsEntity = NSEntityDescription.entity(forEntityName: Entities.Facts, in: self.managedContext)!
    self.searchesEntity = NSEntityDescription.entity(forEntityName: Entities.Searches, in: self.managedContext)!
  }
  
  // MARK: - Categories Methods
  func getSearches() -> [Search] {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.Searches)
    
    do {
      let fetchedResult = try managedContext.fetch(request)
      guard let result = fetchedResult as? [NSManagedObject] else { return [] }
      var searches: [Search] = []
      for data in result {
        guard
          let value = data.value(forKey: Keys.Value) as? String,
          let searchedAt = data.value(forKey: Keys.SearchedAt) as? Date else { return [] }
        let search = Search(value: value, searchedAt: searchedAt)
        searches.append(search)
      }
      return searches
    } catch let error {
      NSLog("\(error.localizedDescription)")
      return []
    }
  }
  
  func insert(search: Search) {
    
    if self.checkIfExists(using: Entities.Searches, where: Keys.Value, equals: search.value) == false {
      let searchObject = NSManagedObject(entity: searchesEntity, insertInto: managedContext)
      searchObject.setValue(search.value, forKey: Keys.Value)
      searchObject.setValue(search.searchedAt, forKey: Keys.SearchedAt)
      
      do {
        try managedContext.save()
      } catch let error {
        NSLog("\(error.localizedDescription)")
      }
    }
  }
  
  // MARK: - Facts Methods
  func getFacts() -> [Fact] {
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
