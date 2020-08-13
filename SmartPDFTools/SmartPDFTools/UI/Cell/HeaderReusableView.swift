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
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}

extension HeaderReusableView {
  func configure() {
    backgroundColor = .clear
    label.textAlignment = .center

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true

    let inset = CGFloat(20)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
    ])
    label.font = UIFont.preferredFont(forTextStyle: .title3)
  }
}

