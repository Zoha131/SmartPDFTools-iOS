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

  let borderLayer: CAShapeLayer = .createBorderLayer()
  var dataSource: UICollectionViewDiffableDataSource<ToolSection, Tool>?

  override func viewDidLoad() {
    super.viewDidLoad()

    fromDrive.applyChooseButtonShadow(withRadius: .fileChooserImageSize / 2)
    fromDevice.applyChooseButtonShadow(withRadius: .bigFileChooserImageSize / 2)
    fromDropbox.applyChooseButtonShadow(withRadius: .fileChooserImageSize / 2)

    chooserCardView.layer.addSublayer(borderLayer)
    borderLayer.updateBorderLayer(with: chooserCardView.bounds)

    dataSource = collectionView.configureMoreToolCollectionView()
    sponsoreView.updateVisibility()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    borderLayer.updateBorderLayer(with: chooserCardView.bounds)
    sponsoreView.updateVisibility()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    borderLayer.updateBorderLayer(with: chooserCardView.bounds)
  }
}