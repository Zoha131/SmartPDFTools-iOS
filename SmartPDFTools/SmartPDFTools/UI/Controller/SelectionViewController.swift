//
//  SelectionViewController.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
  @IBOutlet weak var fromDrive: UIButton!
  @IBOutlet weak var fromDevice: UIButton!
  @IBOutlet weak var fromDropbox: UIButton!
  @IBOutlet weak var chooserCardView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var sponsoreView: UIImageView!

  let chooserCardBorder = CAShapeLayer()
  var dataSource: UICollectionViewDiffableDataSource<ToolSection, Tool>?

  override func viewDidLoad() {
    super.viewDidLoad()

    fromDrive.applyChooseButtonShadow(withRadius: .fileChooserImageSize / 2)
    fromDevice.applyChooseButtonShadow(withRadius: .bigFileChooserImageSize / 2)
    fromDropbox.applyChooseButtonShadow(withRadius: .fileChooserImageSize / 2)

    chooserCardBorder.strokeColor = UIColor.secondaryLabel.cgColor
    chooserCardBorder.lineDashPattern = [10, 8]
    chooserCardBorder.frame = chooserCardView.bounds
    chooserCardBorder.fillColor = UIColor.clear.cgColor
    chooserCardBorder.path = UIBezierPath(roundedRect: chooserCardView.bounds, cornerRadius: 10).cgPath
    chooserCardView.layer.addSublayer(chooserCardBorder)

    // Do any additional setup after loading the view.
    dataSource = collectionView.configureMoreToolCollectionView()
    sponsoreView.updateSponsoreView()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    chooserCardBorder.strokeColor = UIColor.secondaryLabel.cgColor
    sponsoreView.updateSponsoreView()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    chooserCardBorder.frame = chooserCardView.bounds
    chooserCardBorder.path = UIBezierPath(roundedRect: chooserCardView.bounds, cornerRadius: 10).cgPath
  }
}
