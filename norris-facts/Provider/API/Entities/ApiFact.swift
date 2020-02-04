//
//  ApiFacts.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

struct ApiFact: Decodable {
  var categories: [String]
  var createdAt: String
  var iconUrl: String
  var id: String
  var updatedAt: String
  var url: String
  var value: String

  enum CodingKeys: String, CodingKey {
    case categories = "categories"
    case createdAt = "created_at"
    case iconUrl = "icon_url"
    case id = "id"
    case updatedAt = "updated_at"
    case url = "url"
    case value = "value"
  }
}

extension ApiFact {
  var fact: Fact {
    return Fact(id: id, value: value, url: url, categories: categories)
  }
}
