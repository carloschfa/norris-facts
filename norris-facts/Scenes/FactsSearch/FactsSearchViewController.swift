//
//  FactsSearchViewController.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import UIKit

class FactsSearchViewController: UIViewController {
  
  var configurator = FactsSearchConfiguratorImplementation()
  var presenter: FactsSearchPresenter!
  var listPresenter: FactsListPresenter!
  var activityIndicator: UIActivityIndicatorView?

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var suggestionsCollectionView: UICollectionView!
  @IBOutlet weak var pastSearchesTableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    setupUI()
    presenter.defineListPresenter(using: listPresenter)
    presenter.viewDidLoad()
  }
  
  private func setupUI() {
    let suggestionCellNib = UINib(nibName: "SuggestionCollectionViewCell", bundle: Bundle.main)
    self.suggestionsCollectionView.register(suggestionCellNib, forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
    
    let pastSearchesCellNib = UINib(nibName: "PastSearchTableViewCell", bundle: Bundle.main)
    self.pastSearchesTableView.register(pastSearchesCellNib, forCellReuseIdentifier: "PastSearchTableViewCell")
    
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    activityIndicatorView.center = view.center
    self.activityIndicator = activityIndicatorView
    view.addSubview(activityIndicatorView)
    
    
    searchBar.delegate = self
    suggestionsCollectionView.delegate = self
    suggestionsCollectionView.dataSource = self
    pastSearchesTableView.delegate = self
    pastSearchesTableView.dataSource =  self
    
    (suggestionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
  }

}

extension FactsSearchViewController: UISearchBarDelegate { 
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text else { return }
    presenter.search(for: query)
  }
}

extension FactsSearchViewController: FactsSearchView {
  func isLoading(_ value: Bool) {
    value ? activityIndicator?.startAnimating() : activityIndicator?.stopAnimating()
  }
  
  func refreshSearchView(for resultType: ResultType) {
    if resultType == .categories {
      self.suggestionsCollectionView.reloadData()
    }
    if resultType == .searches {
      self.pastSearchesTableView.reloadData()
    }
    
  }
  
  func displaySearchRetrievalError(title: String, message: String) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel,  handler: nil))
    present(alertView, animated: true, completion: nil)
  }
}
