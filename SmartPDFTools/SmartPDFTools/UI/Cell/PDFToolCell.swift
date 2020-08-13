//
//  PDFToolCell.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class PDFToolCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: PDFToolCell.self)

  private let imageView = UIImageView()
  private let titleView = UILabel()

  #warning("Create a protocol to extract this behavior")
  var tool: Tool? {
    didSet {
      if let tool = tool {
        imageView.image = tool.image
        imageView.tintColor = tool.color
        titleView.text = tool.title
        backgroundView?.backgroundColor = tool.color.withAlphaComponent(0.10)
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupShadow()
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard Not Supported")
  }

  func setupShadow() {
    backgroundView = UIView()
    backgroundView?.layer.cornerRadius = contentView.frame.height / 2
  }

  func setupViews() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    titleView.setupToolLabel()
    titleView.textAlignment = .left

    contentView.addSubview(imageView)
    contentView.addSubview(titleView)

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: 19),
      imageView.widthAnchor.constraint(equalToConstant: 19),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      titleView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
      titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      titleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}

