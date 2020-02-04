//
//  FactItemTableViewCell.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/30/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import UIKit

protocol FactItemTableViewCellDelegate: class {
  func shareButtonIsPressed(with text: String , and url: URL?)
}

class FactItemTableViewCell: UITableViewCell {

  @IBOutlet weak var factLabel: UILabel!
  @IBOutlet weak var shareButton: UIButton!
  
  private var data: (text: String, url: URL?)?
  
  weak var delegate: FactItemTableViewCellDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func setupCell(with text: String, and url: URL?) {
    self.data?.text = text
    self.data?.url = url
    factLabel.text = text
    selectionStyle = .none
  }

  @IBAction func shareButtonAction(_ sender: Any) {
    // guard let data = self.data else { return }
    delegate?.shareButtonIsPressed(with: "asdfasdfsda", and: URL(string: "http://github.com"))
  }


}
