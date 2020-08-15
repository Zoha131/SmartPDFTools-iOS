//
//  SelectionViewController.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
  @IBOutlet weak var chooserCardView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var sponsoreView: UIImageView!

  let borderLayer: CAShapeLayer = .createBorderLayer()
  var dataSource: UICollectionViewDiffableDataSource<ToolSection, Tool>?

  let selectionView = SelectionView.fromNib()
  let uploadView = UploadView.fromNib()
  let progressView = ProgressView.fromNib()
  let completeView = CompleteView.fromNib()

  // swiftlint:disable:next implicitly_unwrapped_optional
  var tool: Tool!

  override func viewDidLoad() {
    super.viewDidLoad()

    chooserCardView.layer.addSublayer(borderLayer)
    borderLayer.updateBorderLayer(with: chooserCardView.bounds)

    dataSource = collectionView.configureMoreToolCollectionView()
    sponsoreView.updateVisibility()

    selectionView.setInside(into: chooserCardView)
    selectionView.onDropboxAction = {
      self.moveForward(from: self.selectionView, to: self.uploadView)
    }

    uploadView.onUploadAction = {
      self.moveForward(from: self.uploadView, to: self.progressView)
    }

    progressView.onCancelAction = {
      self.moveForward(from: self.progressView, to: self.completeView)
    }

    title = tool.title
  }

  func moveForward(from viewFrom: UIView, to viewTo: UIView) {
    viewTo.setInside(into: self.chooserCardView)
    viewTo.alpha = 0.0

    UIView.animate(withDuration: 0.4) {
      viewTo.alpha = 1.0
    }

    UIView.animate(
      withDuration: 0.8,
      animations: {
        viewFrom.alpha = 0.0
      }, completion: { _ in
        viewFrom.removeFromSuperview()
      }
    )
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
