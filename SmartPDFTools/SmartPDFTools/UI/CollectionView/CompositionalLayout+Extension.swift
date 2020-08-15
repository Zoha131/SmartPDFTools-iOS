//
//  CompositionalLayout+Extension.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

extension UICollectionViewCompositionalLayout {
  static func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(20)
    )

    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: HeaderReusableView.reuseIdentifier,
      alignment: .top
    )

    return sectionHeader
  }

  static func createSectionShadow() -> NSCollectionLayoutDecorationItem {
    let sectionShadow = NSCollectionLayoutDecorationItem.background(
      elementKind: ShadowReusableView.reuseIdentifier
    )

    return sectionShadow
  }


  static func createConverterSection(for sectionType: ToolSection, isLargeTextOn: Bool, isiPhoneLandscape: Bool) -> NSCollectionLayoutSection {
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
      layoutSection.decorationItems = [UICollectionViewCompositionalLayout.createSectionShadow()]
      layoutSection.boundarySupplementaryItems = [UICollectionViewCompositionalLayout.createSectionHeader()]
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

  static func createMoreToolSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))

    let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
    layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

    let layoutGroupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.93),
      heightDimension: .estimated(100)
    )
    let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

    let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    layoutSection.boundarySupplementaryItems = [UICollectionViewCompositionalLayout.createSectionHeader()]
    layoutSection.orthogonalScrollingBehavior = .continuous
    layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
    return layoutSection
  }

  static func createCompositionalLayoutForMoreTool() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout {  _, _ in
      return UICollectionViewCompositionalLayout.createMoreToolSection()
    }

    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.interSectionSpacing = .paddingNormal
    layout.configuration = configuration

    layout.register(ShadowReusableView.self, forDecorationViewOfKind: ShadowReusableView.reuseIdentifier)

    return layout
  }
}
