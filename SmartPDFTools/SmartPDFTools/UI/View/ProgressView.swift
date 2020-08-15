//
//  ProgressView.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class ProgressView: UIView {
  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var progressTxt: UILabel!
  @IBOutlet weak var titleView: UILabel!
  @IBOutlet weak var animationView: UIView!

  var onCancelAction: (() -> Void)?

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
    button.applyButtonTransparent(withBackgroundColor: .pdfTops)
  }

  @IBAction func cancelAction(_ sender: Any) {
    onCancelAction?()
  }
}
