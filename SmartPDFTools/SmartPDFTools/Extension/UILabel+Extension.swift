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
  func configureLabel(
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
    self.textAlignment = .center
  }

  func configureToolLabel() {
    configureLabel(withTextStyle: .footnote, textColor: .label, numberOfLines: 1, scalFactor: 0.5)
  }

  func configureMegaToolLabel() {
    configureLabel(withTextStyle: .subheadline, textColor: .label, numberOfLines: 1, scalFactor: 0.5)
  }
}
