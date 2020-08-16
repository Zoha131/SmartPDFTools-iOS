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

  var onUploadAction: (() -> Void)?
  var onCancelAction: (() -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configureViews(withColor: .pdfTojpg, image: .pdfTojpg, fileName: "awesome.pdf")
  }

  func configureViews(withColor color: UIColor, image: UIImage, fileName: String) {
    applyRadius()
    uploadButton.applyButtonShadow(withBackgroundColor: color)
    cancelButton.applyButtonTransparent(withBackgroundColor: color)
    toolIcon.tintColor = color
    toolIcon.image = image
    fileLabel.text = fileName
  }

  @IBAction func cancelAction(_ sender: Any) {
    onCancelAction?()
  }

  @IBAction func uploadAction(_ sender: Any) {
    onUploadAction?()
  }
}
