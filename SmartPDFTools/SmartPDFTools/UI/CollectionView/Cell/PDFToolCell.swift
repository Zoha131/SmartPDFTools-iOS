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
    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard Not Supported")
  }

  func configureViews() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    titleView.configureToolLabel()
    titleView.textAlignment = .left

    contentView.addSubview(imageView)
    contentView.addSubview(titleView)

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: .pdfToolSize),
      imageView.widthAnchor.constraint(equalToConstant: .pdfToolSize),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .paddingNormal),
      imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      titleView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .paddingSmall),
      titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.paddingSmall),
      titleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])

    backgroundView = UIView()
    backgroundView?.layer.cornerRadius = contentView.frame.height / 2
  }
}
