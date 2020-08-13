//
//  HeaderReusableView.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/12/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
  static let reuseIdentifier = String(describing: HeaderReusableView.self)

  let label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyaboard is not supported")
  }

  func configureViews() {
    backgroundColor = .clear
    label.textAlignment = .center

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true

    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.topAnchor.constraint(equalTo: topAnchor, constant: .paddingMedium),
      label.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    label.font = UIFont.preferredFont(forTextStyle: .title3)
  }
}
