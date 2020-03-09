//
//  PastSearchesTableView.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 2/6/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Past Searches TableView Methods.

extension FactsSearchViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}

extension FactsSearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PastSearchTableViewCell", for: indexPath) as? PastSearchTableViewCell else {
      return UITableViewCell()
    }
    return cell
  }
  
  
}
