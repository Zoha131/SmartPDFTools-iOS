//
//  PaddingLabel.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class MegaToolTitleView: UIView {
  private let horizontalPadding: CGFloat = 15
  private let verticalPadding: CGFloat = 7
  private let label = UILabel()

  var title: String? {
    didSet {
      label.text = title
      invalidateIntrinsicContentSize()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard not supported")
  }

  func configureViews() {
    label.configureMegaToolLabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding)
    ])

    applyToolShadow()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    invalidateIntrinsicContentSize()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    invalidateIntrinsicContentSize()
  }

  override var intrinsicContentSize: CGSize {
    let size = label.intrinsicContentSize

    let paddingSize = CGSize(
      width: size.width + horizontalPadding + verticalPadding,
      height: size.height + verticalPadding + verticalPadding
    )

    layer.cornerRadius = paddingSize.height / 2

    return paddingSize
  }
}
