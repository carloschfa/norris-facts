//
//  ProviderTests.swift
//  norris-factsTests
//
//  Created by Carlos Henrique Antunes on 2/5/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import XCTest
@testable import norris_facts

class ProviderTests: XCTestCase {

  var apiClient: ApiClient?
  var factsGatewayStub: FactsGateway?
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.apiClient = ApiClientImplementation(urlSessionConfiguration: .default, completionHandlerQueue: .main)
    self.factsGatewayStub = ApiFactsGatewayImplementation(apiClient: apiClient!)
    
    
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.factsGatewayStub = nil
    self.apiClient = nil
    
  }
  
  func testFetchRandom() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factStub: Fact?
    var errorStub: Error?
    
    // When
    factsGatewayStub?.fetchRandom { (result) in
      switch result {
      case .success(let fact):
        factStub = fact
      case .failure(let error):
        errorStub = error
      }
      loadExpectation.fulfill()
    }
    wait(for: [loadExpectation], timeout: 3.0)
    
    // Then
    XCTAssertNotNil(factStub)
    XCTAssertNil(errorStub)
    
  }

  func testFetchBySearch() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factsStub: [Fact] = []
    var errorStub: Error?
    let query = "science"
    
    // When
    factsGatewayStub?.fetchBySearch(with: query) { (result) in
      switch result {
      case .success(let facts):
        factsStub = facts
      case .failure(let error):
        errorStub = error
      }
      loadExpectation.fulfill()
    }
    wait(for: [loadExpectation], timeout: 3.0)
    
    // Then
    XCTAssert(factsStub.count > 0)
    XCTAssertNil(errorStub)
  }
  
  func testFetchBySearchNoResults() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factsStub: [Fact] = []
    var errorStub: Error?
    let query = "sdfee22"
    
    // When
    factsGatewayStub?.fetchBySearch(with: query) { (result) in
      switch result {
      case .success(let facts):
        factsStub = facts
      case .failure(let error):
        errorStub = error
      }
      loadExpectation.fulfill()
    }
    wait(for: [loadExpectation], timeout: 3.0)
    
    // Then
    XCTAssert(factsStub.count == 0)
    XCTAssertNil(errorStub)
  }
  
  func testFetchBySearchFailure() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factsStub: [Fact] = []
    var errorStub: Error?
    let query = "22"
    
    // When
    factsGatewayStub?.fetchBySearch(with: query) { (result) in
      switch result {
      case .success(let facts):
        factsStub = facts
      case .failure(let error):
        errorStub = error
      }
      loadExpectation.fulfill()
    }
    wait(for: [loadExpectation], timeout: 3.0)
    
    // Then
    XCTAssert(factsStub.count == 0)
    XCTAssertNotNil(errorStub)
  }
  
  func testFetchCategories() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var categoriesStub: [String] = []
    var errorStub: Error?
    
    // When
    factsGatewayStub?.fetchCategories { (result) in
      switch result {
      case .success(let categories):
        categoriesStub = categories
      case .failure(let error):
        errorStub = error
      }
      loadExpectation.fulfill()
    }
    wait(for: [loadExpectation], timeout: 3.0)
    
    // Then
    XCTAssertGreaterThan(categoriesStub.count, 0)
    XCTAssertNil(errorStub)
  }
  
  func testFetchByCategory() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factStub: Fact?
    var errorStub: Error?
    let query: String = "celebrity"
    
    // When
    factsGatewayStub?.fetchByCategory(with: query) { (result) in
      switch result {
      case .success(let fact):
        factStub = fact
      case .failure(let error):
        errorStub = error
      }
      loadExpectation.fulfill()
    }
    wait(for: [loadExpectation], timeout: 3.0)
    
    // Then
    XCTAssertNotNil(factStub)
    XCTAssertNil(errorStub)
  }
  
  func testFetchByCategoryFailure() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factStub: Fact?
    var errorStub: Error?
    let query: String = "123"
    
    // When
    factsGatewayStub?.fetchByCategory(with: query) { (result) in
      switch result {
      case .success(let fact):
        factStub = fact
      case .failure(let error):
        errorStub = error
      }
      loadExpectation.fulfill()
    }
    wait(for: [loadExpectation], timeout: 3.0)
    
    // Then
    XCTAssertNil(factStub)
    XCTAssertNotNil(errorStub)
  }
  
}
