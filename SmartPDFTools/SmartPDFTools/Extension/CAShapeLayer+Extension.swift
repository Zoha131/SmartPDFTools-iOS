//
//  CAShapeLayer.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

extension CAShapeLayer {
  static func createBorderLayer() -> CAShapeLayer {
    let borderLayer = CAShapeLayer()

    borderLayer.strokeColor = UIColor.secondaryLabel.cgColor
    borderLayer.lineDashPattern = [10, 8]
    borderLayer.frame = CGRect()
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.path = UIBezierPath(roundedRect: CGRect(), cornerRadius: 10).cgPath

    return borderLayer
  }

  func updateBorderLayer(with bounds: CGRect) {
    frame = bounds
    path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    strokeColor = UIColor.secondaryLabel.cgColor
  }
}
