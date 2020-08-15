//
//  MegaToolCell.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class MegaToolCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: MegaToolCell.self)

  private let imageView = UIImageView()
  private let titleView = MegaToolTitleView()
  private let toolBackgroundView = UIView()

  var tool: Tool? {
    didSet {
      if let tool = tool {
        imageView.image = tool.image
        imageView.tintColor = tool.color
        titleView.title = tool.title
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureShadowView()
    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard Not Supported")
  }

  func configureShadowView() {
    toolBackgroundView.applyCardShadow()
    toolBackgroundView.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(toolBackgroundView)

    NSLayoutConstraint.activate([
      toolBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
      toolBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      toolBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .paddingLarge),
      toolBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }

  func configureViews() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(imageView)
    contentView.addSubview(titleView)

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: .megaToolSize),
      imageView.widthAnchor.constraint(equalToConstant: .megaToolSize),
      imageView.topAnchor.constraint(equalTo: toolBackgroundView.topAnchor, constant: .paddingMedium),
      imageView.centerXAnchor.constraint(equalTo: toolBackgroundView.centerXAnchor),

      titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .paddingNormal),
      titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.paddingNormal)
    ])
  }
}
