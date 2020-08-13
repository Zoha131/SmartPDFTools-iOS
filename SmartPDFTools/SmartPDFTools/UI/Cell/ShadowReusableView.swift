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

    setupShadow()

  }

  required init?(coder: NSCoder) {
    fatalError("Storyboard Not Supported")
  }

  func setupShadow() {
    let shadowView = UIView()
    shadowView.translatesAutoresizingMaskIntoConstraints = false

    shadowView.backgroundColor = .tertiarySystemBackground
    shadowView.layer.cornerRadius = 10
    shadowView.layer.shadowColor = UIColor.black.cgColor
    shadowView.layer.shadowRadius = 5
    shadowView.layer.shadowOpacity = 0.1
    shadowView.layer.shadowOffset = CGSize(width: 0, height: 5)

    addSubview(shadowView)

    NSLayoutConstraint.activate([
      shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
      shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
      shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
    ])
  }
}
