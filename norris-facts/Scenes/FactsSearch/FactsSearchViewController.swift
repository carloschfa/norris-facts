//
//  FactsSearchViewController.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import UIKit

#warning("CHECKPOINT: IMPLEMENTING SEARCH MODULE STRUCTURE.")
class FactsSearchViewController: UIViewController {
  
  var configurator = FactsSearchConfiguratorImplementation()
  var presenter: FactsSearchPresenter!

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var suggestionsCollectionView: UICollectionView!
  @IBOutlet weak var pastSearchesTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    setupUI()
    // Do any additional setup after loading the view.
  }
  
  private func setupUI() {
    let suggestionCellNib = UINib(nibName: "SuggestionCollectionViewCell", bundle: Bundle.main)
    self.suggestionsCollectionView.register(suggestionCellNib, forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
    
    let pastSearchesCellNib = UINib(nibName: "PastSearchTableViewCell", bundle: Bundle.main)
    self.pastSearchesTableView.register(pastSearchesCellNib, forCellReuseIdentifier: "PastSearchTableViewCell")
    
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
    print("touced to search -> \(searchBar.text)")
  }
}

extension FactsSearchViewController: FactsSearchView {
  func isLoading(_ value: Bool) {
    
  }
}
