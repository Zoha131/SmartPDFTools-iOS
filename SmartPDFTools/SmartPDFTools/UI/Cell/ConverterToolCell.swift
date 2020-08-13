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

  private let imageView = UIImageView()
  private let titleView = UILabel()

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
    setupShadow()
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard Not Supported")
  }

  func setupShadow() {
    backgroundView = UIView()
    backgroundView?.backgroundColor = .secondarySystemBackground
    backgroundView?.layer.cornerRadius = 10
    backgroundView?.layer.shadowColor = UIColor.black.cgColor
    backgroundView?.layer.shadowRadius = 3
    backgroundView?.layer.shadowOpacity = 0.1
    backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 3)
  }

  func setupViews() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    titleView.setupToolLabel()
    titleView.textAlignment = .center

    contentView.addSubview(imageView)
    contentView.addSubview(titleView)

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: 35),
      imageView.widthAnchor.constraint(equalToConstant: 35),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

      titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
      titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
      titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
      titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
    ])
  }
}
