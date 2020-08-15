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
  var onDownloadAction: (() -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configureViews()
  }

  private func configureViews() {
    applyRadius()
    downloadButton.applyButtonShadow(withBackgroundColor: .pdfTops)
  }
  @IBAction func downloadAction(_ sender: Any) {
    onDownloadAction?()
  }
}
