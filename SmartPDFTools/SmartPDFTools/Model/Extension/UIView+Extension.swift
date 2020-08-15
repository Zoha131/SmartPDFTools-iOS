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

  func applyChooseButtonShadow(withRadius radius: CGFloat) {
    applyShaddow(
      withRadius: radius,
      backgroundColor: .cardBackground,
      shadowColor: .black,
      shadowOpacity: 0.1
    )
  }

  func updateSponsoreView() {
    let screenHeight = UIScreen.main.bounds.height

    if screenHeight < 800 {
      isHidden = true
    } else {
      isHidden = false
    }
  }
}
