//
//  Result.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

struct CoreError: Error {
  var localizedDescription: String {
    return message
  }

  var message = ""
}

// See https://github.com/antitypical/Result
enum Result<T> {
  case success(T)
  case failure(Error)

  public func dematerialize() throws -> T {
    switch self {
    case let .success(value):
      return value
    case let .failure(error):
      throw error
    }
  }
}
