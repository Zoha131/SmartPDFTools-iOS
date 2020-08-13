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
    createDataSource()
    reloadData()
  }

  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout {  sectionIdex, _ in
      let sectionType = ToolSection.allCases[sectionIdex]

      let isRegularWidth = self.traitCollection.horizontalSizeClass  == .regular
      let isCompactHeight = self.traitCollection.verticalSizeClass  == .compact
      let isiPhoneLandscape = isRegularWidth && isCompactHeight

      let isLargeTextOn = self.traitCollection.preferredContentSizeCategory.isAccessibilityCategory

      return self.createConverterSection(
        for: sectionType,
        isLargeTextOn: isLargeTextOn,
        isiPhoneLandscape: isiPhoneLandscape
      )
    }

    layout.register(ShadowReusableView.self, forDecorationViewOfKind: ShadowReusableView.reuseIdentifier)

    return layout
  }

  func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(44)
    )

    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: HeaderReusableView.reuseIdentifier,
      alignment: .top
    )

    return sectionHeader
  }

  func createSectionShadow() -> NSCollectionLayoutDecorationItem {
    let sectionShadow = NSCollectionLayoutDecorationItem.background(
      elementKind: ShadowReusableView.reuseIdentifier
    )

    return sectionShadow
  }

  func createConverterSection(for sectionType: ToolSection, isLargeTextOn: Bool, isiPhoneLandscape: Bool) -> NSCollectionLayoutSection {
    let defaultIemCount: Int
    let defaultGroupSpacing: CGFloat
    let defaultImtemHeight: CGFloat
    var hasShadowDecoration = true

    switch sectionType {
    case .word, .html, .powerpoint:
      defaultIemCount = 2
      defaultGroupSpacing = .twoItemGroupSpacing
      defaultImtemHeight = .itemHeight
    case .pdf:
      defaultIemCount = 2
      defaultGroupSpacing = .groupSpacing
      defaultImtemHeight = .pdfItemHeight
    case .mega:
      defaultIemCount = 2
      defaultGroupSpacing = .groupSpacing
      defaultImtemHeight = .megaItemHeight
      hasShadowDecoration = false
    default:
      defaultIemCount = 3
      defaultGroupSpacing = .groupSpacing
      defaultImtemHeight = .itemHeight
    }

    let itemGroupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(defaultImtemHeight)
    )
    let layoutItem = NSCollectionLayoutItem(layoutSize: itemGroupSize)

    let itemCount = isLargeTextOn ? 1 : defaultIemCount
    let layoutGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: itemGroupSize,
      subitem: layoutItem,
      count: itemCount
    )

    let interGroupSpacing: CGFloat = isiPhoneLandscape ? .paddingSmall : defaultGroupSpacing
    layoutGroup.interItemSpacing = .fixed(interGroupSpacing)

    let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    if hasShadowDecoration {
      layoutSection.decorationItems = [self.createSectionShadow()]
      layoutSection.boundarySupplementaryItems = [self.createSectionHeader()]
    }

    let sectionContentInset: CGFloat = isiPhoneLandscape ? .paddingMedium : .paddingLarge
    layoutSection.interGroupSpacing = isiPhoneLandscape ? .paddingSmall : .paddingMedium
    layoutSection.contentInsets = NSDirectionalEdgeInsets(
      top: sectionContentInset,
      leading: sectionContentInset,
      bottom: sectionContentInset,
      trailing: sectionContentInset
    )

    return layoutSection
  }

  func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<ToolSection, Tool>(
      collectionView: collectionView
    ) { collectionView, indexPath, tool in
      let sectionType = ToolSection.allCases[indexPath.section]

      switch sectionType {
      case .pdf:
        guard let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: PDFToolCell.reuseIdentifier,
          for: indexPath
          ) as? PDFToolCell else {
            fatalError("Unable to dequeue")
        }

        cell.tool = tool

        return cell
      case .mega:
        guard let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: MegaToolCell.reuseIdentifier,
          for: indexPath
          ) as? MegaToolCell else {
            fatalError("Unable to dequeue")
        }

        cell.tool = tool

        return cell
      default:
        guard let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: ConverterToolCell.reuseIdentifier,
          for: indexPath
          ) as? ConverterToolCell else {
            fatalError("Unable to dequeue")
        }

        cell.tool = tool

        return cell
      }
    }

    dataSource?.supplementaryViewProvider = {(
      collectionView: UICollectionView,
      kind: String,
      indexPath: IndexPath) -> UICollectionReusableView? in

      guard let headerSuplementary = collectionView.dequeueReusableSupplementaryView(
        ofKind: HeaderReusableView.reuseIdentifier,
        withReuseIdentifier: HeaderReusableView.reuseIdentifier,
        for: indexPath
        ) as? HeaderReusableView else {
        fatalError("Headerview not found")
      }

      let section = ToolSection.allCases[indexPath.section]
      headerSuplementary.label.text = "\(section.rawValue.uppercased()) Converter"

      return headerSuplementary
    }
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
  }
}
