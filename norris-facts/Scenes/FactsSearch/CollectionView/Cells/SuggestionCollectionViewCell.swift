//
//  SuggestionCollectionViewCell.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 2/6/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import UIKit

protocol SuggestionCollectionViewCellDelegate: class {
  func suggestionItemIsPressed(with value: String)
}

class SuggestionCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak var suggestionLabel: UILabel!
  @IBOutlet weak var suggestionButton: UIView!
  
  weak var delegate: SuggestionCollectionViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.suggestionActionButton(_:)))
    self.suggestionButton.addGestureRecognizer(gesture)
    // Initialization code
  }
  
  func configureCell(category: Category) {
    self.suggestionLabel.text = category.value
  }
  
  @objc func suggestionActionButton(_ sender:UITapGestureRecognizer){
    guard let value = self.suggestionLabel.text else { return }
    delegate?.suggestionItemIsPressed(with: value)
  }
  
  
}
