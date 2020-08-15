//
//  SelectionView.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class SelectionView: UIView {
  @IBOutlet weak var fromDriveButton: UIButton!
  @IBOutlet weak var fromDropboxButton: UIButton!
  @IBOutlet weak var fromDeviceButton: UIButton!

  var onDriveAction: (() -> Void)?
  var onDeviceAction: (() -> Void)?
  var onDropboxAction: (() -> Void)?

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
    fromDriveButton.applyChooseButtonShadow(withRadius: .fileChooserImageSize / 2)
    fromDeviceButton.applyChooseButtonShadow(withRadius: .bigFileChooserImageSize / 2)
    fromDropboxButton.applyChooseButtonShadow(withRadius: .fileChooserImageSize / 2)
  }
  @IBAction func driveAction(_ sender: Any) {
    onDriveAction?()
  }
  @IBAction func deviceAction(_ sender: Any) {
    onDeviceAction?()
  }
  @IBAction func dropboxAction(_ sender: Any) {
    onDropboxAction?()
  }
}
