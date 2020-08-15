//
//  ConverterToolCell.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/12/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class ConverterToolCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: UICollectionViewCell.self)

  let imageView = UIImageView()
  let titleView = UILabel()

  var tool: Tool? {
    didSet {
      if let tool = tool {
        imageView.image = tool.image
        imageView.tintColor = tool.color
        titleView.text = tool.title
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard Not Supported")
  }

  func configureViews() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    titleView.configureToolLabel()

    contentView.addSubview(imageView)
    contentView.addSubview(titleView)

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: .toolSize),
      imageView.widthAnchor.constraint(equalToConstant: .toolSize),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .paddingNormal),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

      titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .paddingTiny),
      titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.paddingTiny),
      titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .paddingNormal),
      titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.paddingSmall)
    ])

    backgroundView = UIView()
    backgroundView?.applyToolShadow()
  }
}
