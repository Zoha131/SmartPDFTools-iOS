//
//  ShadowReusableView.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/12/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class ShadowReusableView: UICollectionReusableView {
  static let reuseIdentifier = String(describing: ShadowReusableView.self)

  override init(frame: CGRect) {
    super.init(frame: frame)

    configureViews()
  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard Not Supported")
  }

  func configureViews() {
    let shadowView = UIView()
    shadowView.translatesAutoresizingMaskIntoConstraints = false
    shadowView.applyCardShadow()

    addSubview(shadowView)

    NSLayoutConstraint.activate([
      shadowView.topAnchor.constraint(equalTo: self.topAnchor),
      shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.paddingSmall),
      shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .paddingSmall),
      shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.paddingSmall)
    ])
  }
}
