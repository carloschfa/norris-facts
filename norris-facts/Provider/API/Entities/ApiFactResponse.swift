//
//  ApiFactResponse.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 2/5/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

struct ApiFactResponse: Decodable {
  let total: Int
  let facts: [ApiFact]
  
  enum CodingKeys: String, CodingKey {
    case total = "total"
    case facts = "result"
  }
}
