//
//  FactsListTests.swift
//  norris-factsTests
//
//  Created by Carlos Henrique Antunes on 2/6/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import XCTest
@testable import norris_facts

class FactsListTests: XCTestCase {

  var factsListRouterStub: FactsListRouter?
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    let factListViewControllerStub = FactsListTableViewController()
    self.factsListRouterStub = FactsListRouterImplementation(factsListViewController: factListViewControllerStub)
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.factsListRouterStub = nil
    
  }
  
  
}
