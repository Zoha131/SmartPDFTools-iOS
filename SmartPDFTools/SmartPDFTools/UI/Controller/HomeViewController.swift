//
//  HomeViewController.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/12/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!

  var dataSource: UICollectionViewDiffableDataSource<ToolSection, Tool>?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    collectionView.register(ConverterToolCell.self, forCellWithReuseIdentifier: ConverterToolCell.reuseIdentifier)
    collectionView.register(PDFToolCell.self, forCellWithReuseIdentifier: PDFToolCell.reuseIdentifier)
    collectionView.register(MegaToolCell.self, forCellWithReuseIdentifier: MegaToolCell.reuseIdentifier)
    collectionView.register(
      HeaderReusableView.self,
      forSupplementaryViewOfKind: HeaderReusableView.reuseIdentifier,
      withReuseIdentifier: HeaderReusableView.reuseIdentifier
    )

    collectionView.collectionViewLayout = createCompositionalLayout()
    collectionView.delegate = self
    collectionView.contentInset.bottom = .collectionViewBottomInset
    collectionView.contentInset.top = .collectionViewTopInset
    dataSource = .createDataSource(for: collectionView)
    reloadData()
  }

  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout {  sectionIdex, _ in
      let sectionType = ToolSection.allCases[sectionIdex]

      let isRegularWidth = self.traitCollection.horizontalSizeClass  == .regular
      let isCompactHeight = self.traitCollection.verticalSizeClass  == .compact
      let isiPhoneLandscape = isRegularWidth && isCompactHeight

      let isLargeTextOn = self.traitCollection.preferredContentSizeCategory.isAccessibilityCategory

      return UICollectionViewCompositionalLayout.createConverterSection(
        for: sectionType,
        isLargeTextOn: isLargeTextOn,
        isiPhoneLandscape: isiPhoneLandscape
      )
    }

    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.interSectionSpacing = .paddingNormal
    layout.configuration = configuration

    layout.register(ShadowReusableView.self, forDecorationViewOfKind: ShadowReusableView.reuseIdentifier)

    return layout
  }

  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<ToolSection, Tool>()
    snapshot.appendSections(ToolSection.allCases)

    ToolSection.allCases.forEach { section in
      guard let tools = Tool.allToolMap[section] else {
        fatalError("Tools not found for section \(section.rawValue)")
      }

      snapshot.appendItems(tools, toSection: section)
    }

    dataSource?.apply(snapshot)
  }
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("\(ToolSection.allCases[indexPath.section])")
    performSegue(withIdentifier: "homeDetail", sender: nil)
  }
}
