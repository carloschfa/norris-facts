//
//  FactsSearchConfigurator.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

protocol FactsSearchConfigurator {
  func configure(with factsSearchViewController: FactsSearchViewController)
}

class FactsSearchConfiguratorImplementation: FactsSearchConfigurator {
  func configure(with factsSearchViewController: FactsSearchViewController) {
    let apiClient = ApiClientImplementation(urlSessionConfiguration: .default, completionHandlerQueue: .main)
    let apiFactsGateway = ApiFactsGatewayImplementation(apiClient: apiClient)

    let displayFactsUseCase = DisplayFactsUseCaseImplementation(factsGateway: apiFactsGateway)

    let router  = FactsSearchRouterImplementation()
    router.factsSearchViewController = factsSearchViewController

    let presenter = FactsSearchPresenterImplementation(view: factsSearchViewController,
                                                       displayFactsUseCase: displayFactsUseCase,
                                                       router: router)
    
    factsSearchViewController.presenter = presenter
  }

}
