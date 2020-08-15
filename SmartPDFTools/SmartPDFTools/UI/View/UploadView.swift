//
//  UploadView.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class UploadView: UIView {
  @IBOutlet weak var toolIcon: UIImageView!
  @IBOutlet weak var fileLabel: UILabel!
  @IBOutlet weak var uploadButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configureViews(withColor: .pdfTops, fileName: "awesome.pdf")
  }

  private func configureViews(withColor color: UIColor, fileName: String) {
    applyRadius()
    uploadButton.applyButtonShadow(withBackgroundColor: color)
    cancelButton.applyButtonTransparent(withBackgroundColor: color)
    toolIcon.tintColor = color
    fileLabel.text = fileName
  }
}
