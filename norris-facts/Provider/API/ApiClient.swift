//
//  ApiClient.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

protocol ApiRequest {
  var urlRequest: URLRequest { get }
}

protocol ApiClient {
  func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

protocol URLSessionProtocol {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImplementation: ApiClient {
  let urlSession: URLSessionProtocol
  
  init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
    urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
  }
  
  // This should be used mainly for testing purposes
  init(urlSession: URLSessionProtocol) {
    self.urlSession = urlSession
  }
  
  // MARK: - ApiClient
  
  func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
    let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
      guard let httpUrlResponse = response as? HTTPURLResponse else {
        completionHandler(.failure(NetworkRequestError(error: error)))
        return
      }
      
      let successRange = 200...299
      if successRange.contains(httpUrlResponse.statusCode) {
        do {
          let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
          completionHandler(.success(response))
        } catch {
          completionHandler(.failure(error))
        }
      } else {
        completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
      }
    }
    dataTask.resume()
  }
}
