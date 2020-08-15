//
//  UIView+Extension.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

extension UIView {
  func applyShaddow(withRadius radius: CGFloat, backgroundColor: UIColor, shadowColor: UIColor, shadowOpacity: Float) {
    self.backgroundColor = backgroundColor
    layer.cornerRadius = radius
    layer.shadowColor = shadowColor.cgColor
    layer.shadowRadius = 3
    layer.shadowOpacity = shadowOpacity
    layer.shadowOffset = CGSize(width: 0, height: 3)
  }

  func applyCardShadow() {
    applyShaddow(
      withRadius: 10,
      backgroundColor: .cardBackground,
      shadowColor: .black,
      shadowOpacity: 0.1
    )
  }

  func applyToolShadow() {
    applyShaddow(
      withRadius: 8,
      backgroundColor: .toolBackground,
      shadowColor: .black,
      shadowOpacity: 0.1
    )
  }

  func updateVisibility() {
    let screenHeight = UIScreen.main.bounds.height

    if screenHeight < 800 {
      isHidden = true
    } else {
      isHidden = false
    }
  }

  func applyRadius(_ radius: CGFloat = 10) {
    layer.cornerRadius = radius
    clipsToBounds = true
  }

  static func fromNib() -> Self {
    let name = "\(Self.self)"
    guard
      let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
      else { fatalError("missing expected nib named: \(name)") }
    guard
      /// we're using `first` here because compact map chokes compiler on
      /// optimized release, so you can't use two views in one nib if you wanted to
      /// and are now looking at this
      let view = nib.first as? Self
      else { fatalError("view of type \(Self.self) not found in \(nib)") }
    return view
  }
}
