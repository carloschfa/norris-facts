//
//  SuggestionsCollectionView.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 2/6/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Suggestions CollectionView Methods.

extension FactsSearchViewController: UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}

extension FactsSearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as? SuggestionCollectionViewCell else {
      return UICollectionViewCell()
    }
    return cell
  }
}
