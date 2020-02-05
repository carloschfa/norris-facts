//
//  ExtensionsTests.swift
//  norris-factsTests
//
//  Created by Carlos Henrique Antunes on 2/5/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//


import XCTest
@testable import norris_facts

class ExtensionsTests: XCTestCase {

  // MARK: - Array Tests
  
  func testArrayToJsonData() {
    // Given
    var arrayStub: [Any]
    
    // When
    arrayStub = [Any]()
    arrayStub.append([3, "abc", 44, "Testing"])
    
    // Then
    XCTAssertGreaterThan(arrayStub.toJsonData().data!.count, 0)
    XCTAssertNil(arrayStub.toJsonData().error)
    
  }
  
  func testArrayToJsonDataFailure() {
    // Given
    var arrayStub: [String] = []
    
    // When
    arrayStub = ["bad input"]
    
    // Then
    XCTAssertNil(arrayStub.toJsonData().data)
    XCTAssertNotNil(arrayStub.toJsonData().error)
    
  }
  
  // MARK: - Dictionary Tests
  
  func testDictionaryToJsonData() {
    // Given
    var dicStub: [String : Any]
    
    // When
    dicStub = [String : Any]()
    dicStub["first"] = [3, "abc", 44, "Testing"]
    
    // Then
    XCTAssertGreaterThan(dicStub.toJsonData().data!.count, 0)
    XCTAssertNil(dicStub.toJsonData().error)
    
  }
  
  func testDictionaryToJsonDataFailure() {
    // Given
    var dicStub: [String : Any] = [:]
    
    // When
    dicStub = ["errorTag": "bad input"]
    
    // Then
    XCTAssertNil(dicStub.toJsonData().data)
    XCTAssertNotNil(dicStub.toJsonData().error)
    
  }
  
  // MARK: - NSError Tests
  
  func testCreatePraseError() {
    // Given
    var newErrorStub: NSError?
    
    // When
    newErrorStub = NSError.createPraseError()
      
    // Then
    XCTAssertNotNil(newErrorStub)
    XCTAssertEqual(newErrorStub?.domain, "com.carloschfa.library")
  }
  
}
