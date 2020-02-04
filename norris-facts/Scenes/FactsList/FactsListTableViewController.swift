//
//  FactsListTableViewController.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import UIKit

class FactsListTableViewController: UITableViewController {
  var configurator = FactsListConfiguratorImplementation()
  var presenter: FactsListPresenter!
  var activityIndicator: UIActivityIndicatorView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    setupUI()
    presenter.viewDidLoad()
  }

  private func setupUI() {
    let cellNib = UINib(nibName: "FactItemTableViewCell", bundle: Bundle.main)
    self.tableView.register(cellNib, forCellReuseIdentifier: "FactItemTableViewCell")
    
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    tableView.backgroundView = activityIndicatorView
    tableView.separatorStyle = .none
    self.activityIndicator = activityIndicatorView
    
    addSearchButton()
  }
  
  private func addSearchButton() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(self.searchButtonTapped))
  }
  
  
  @objc private func searchButtonTapped(sender: Any) {
    presenter.searchButtonPressed()
  }

}

// MARK: - TableViewDelegate methods.

extension FactsListTableViewController {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FactItemTableViewCell", for: indexPath) as? FactItemTableViewCell else {
      return UITableViewCell()
    }
    presenter.configureCell(with: cell, forRow: indexPath.row)
    return cell
  }
}

// MARK: - TableViewDataSource methods.

extension FactsListTableViewController {
  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return presenter.numberOfFacts
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

}

extension FactsListTableViewController: FactsListView {
  func refreshFactsView() {
    tableView.reloadData()
  }

  func displayFactsRetrievalError(title: String, message: String) {
    print("Error -> \(message)")
  }
  
  func isLoading(_ value: Bool) {
    value ? activityIndicator?.startAnimating() : activityIndicator?.stopAnimating()
  }
}
