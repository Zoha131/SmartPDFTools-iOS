//
//  FileChooserCell.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/14/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class FileChooserCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: UICollectionViewCell.self)

  let imageView = UIImageView()
  let titleView = UILabel()

  var image: UIImage? {
    didSet {
      imageView.image = image
    }
  }

  var title: String? {
    didSet {
      titleView.text = title
    }
  }

  var imageSize: CGFloat = .fileChooserImageSize {
    didSet {
      resizeImage()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard not supported")
  }

  private func configureViews() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleView.translatesAutoresizingMaskIntoConstraints = false

    titleView.textAlignment = .center

    contentView.addSubview(imageView)
    contentView.addSubview(titleView)

    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor),

      titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])

    resizeImage()
  }

  private func resizeImage() {
    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: imageSize),
      imageView.widthAnchor.constraint(equalToConstant: imageSize)
    ])
  }
}
