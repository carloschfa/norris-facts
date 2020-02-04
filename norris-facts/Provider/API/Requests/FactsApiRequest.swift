//
//  FactsApiRequest.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

struct FactsRandomApiRequest: ApiRequest {
  var urlRequest: URLRequest {
    let url: URL! = URL(string: "https://api.chucknorris.io/jokes/random")
    var request = URLRequest(url: url)

    request.httpMethod = "GET"

    return request
  }
}

struct FactsBySearchApiRequest: ApiRequest {
  let query: String

  var urlRequest: URLRequest {
    let url: URL! = URL(string: "https://api.chucknorris.io/jokes/search?query=\(query)")
    var request = URLRequest(url: url)

    request.httpMethod = "GET"

    return request
  }
}

struct CategoriesApiRequest: ApiRequest {
  var urlRequest: URLRequest {
    let url: URL! = URL(string: "https://api.chucknorris.io/jokes/categories")
    var request = URLRequest(url: url)

    request.httpMethod = "GET"

    return request
  }
}

struct FactByCategoryApiRequest: ApiRequest {
  let category: String

  var urlRequest: URLRequest {
    let url: URL! = URL(string: "https://api.chucknorris.io/jokes/random?category=\(category)")
    var request = URLRequest(url: url)

    request.httpMethod = "GET"

    return request
  }
}
