//
//  FactsGatewayTests.swift
//  norris-factsTests
//
//  Created by Carlos Henrique Antunes on 2/5/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import XCTest
@testable import norris_facts

class CoreTests: XCTestCase {

  var apiClient: ApiClient?
  var displayFactsUseCase: DisplayFactsUseCase?
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.apiClient = ApiClientImplementation(urlSessionConfiguration: .default, completionHandlerQueue: .main)
    let factsGatewayStub = ApiFactsGatewayImplementation(apiClient: apiClient!)
    self.displayFactsUseCase = DisplayFactsUseCaseImplementation(factsGateway: factsGatewayStub)
    
    
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.displayFactsUseCase = nil
    self.apiClient = nil
    
  }

func testDisplayRandomSuccess() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factStub: Fact?
    var errorStub: Error?
    
    // When
    displayFactsUseCase?.displayRandom { (result) in
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
  
  func testDisplayBySearch() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factsStub: [Fact] = []
    var errorStub: Error?
    let query: String = "science"
    
    // When
    displayFactsUseCase?.displayBySearch(with: query) { (result) in
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
  
  func testDisplayCategories() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var categoriesStub: [String] = []
    var errorStub: Error?
    
    // When
    displayFactsUseCase?.displayCategories { (result) in
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
    XCTAssert(categoriesStub.count > 0)
    XCTAssertNil(errorStub)
    
  }
  
  func testDisplayByCategory() {
    // Given
    let loadExpectation = expectation(description: "loadDataExpectation")
    var factStub: Fact?
    var errorStub: Error?
    let category: String = "celebrity"
    
    // When
    displayFactsUseCase?.displayByCategory(with: category ) { (result) in
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
  
}
