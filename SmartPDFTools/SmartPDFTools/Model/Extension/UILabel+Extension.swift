//
//  UILabel+Extension.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation

import UIKit

extension UILabel {
  func setupLabel(
    withTextStyle style: UIFont.TextStyle,
    textColor: UIColor,
    numberOfLines: Int,
    scalFactor: CGFloat
  ) {
    font = .preferredFont(forTextStyle: style)
    adjustsFontForContentSizeCategory = true

    minimumScaleFactor = scalFactor
    adjustsFontSizeToFitWidth = true

    self.textColor = textColor
    self.numberOfLines = numberOfLines
  }

  func setupToolLabel() {
    setupLabel(withTextStyle: .body, textColor: .label, numberOfLines: 1, scalFactor: 0.5)
  }
}
