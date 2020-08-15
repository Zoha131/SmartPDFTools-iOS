//
//  UIButton+Extension.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

extension UIButton {
  func applyButtonShadow(withBackgroundColor color: UIColor) {
    backgroundColor = color
    layer.cornerRadius = 8
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowRadius = 5
    layer.shadowOpacity = 0.1
    layer.shadowOffset = CGSize(width: 0, height: 3)
  }

  func applyButtonTransparent(withBackgroundColor color: UIColor) {
    backgroundColor = color.withAlphaComponent(0.10)
    setTitleColor(color, for: .normal)
    layer.cornerRadius = 8
  }

  func applyChooseButtonShadow(withRadius radius: CGFloat) {
    applyShaddow(
      withRadius: radius,
      backgroundColor: .cardBackground,
      shadowColor: .black,
      shadowOpacity: 0.1
    )
  }
}
