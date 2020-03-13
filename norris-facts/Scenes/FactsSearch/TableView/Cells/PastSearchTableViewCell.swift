//
//  PastSearchTableViewCell.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 2/6/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import UIKit

protocol PastSearchTableViewCellDelegate: class {
  func searchItemIsPressed(with value: String)
}

class PastSearchTableViewCell: UITableViewCell {
  
  @IBOutlet weak var searchLabel: UILabel!
  @IBOutlet weak var searchButton: UIView!
  
  weak var delegate: PastSearchTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.searchActionButton(_:)))
    self.searchButton.addGestureRecognizer(gesture)
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configureCell(search: Search) {
    self.searchLabel.text = search.value
  }
  
  @objc func searchActionButton(_ sender:UITapGestureRecognizer){
    guard let value = self.searchLabel.text else { return }
    delegate?.searchItemIsPressed(with: value)
  }
  
}
