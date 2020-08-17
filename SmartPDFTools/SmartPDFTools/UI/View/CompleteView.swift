//
//  CopmpleteView.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class CompleteView: UIView {
  @IBOutlet weak var downloadButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var image: UIImageView!
  
  var onDownloadAction: (() -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func configureViews(withColor color: UIColor, title: String, buttonTitle: String) {
    applyRadius()
    titleLabel.text = title
    downloadButton.applyButtonShadow(withBackgroundColor: color)
    downloadButton.setTitle(buttonTitle, for: .normal)
  }
  @IBAction func downloadAction(_ sender: Any) {
    onDownloadAction?()
  }
}
