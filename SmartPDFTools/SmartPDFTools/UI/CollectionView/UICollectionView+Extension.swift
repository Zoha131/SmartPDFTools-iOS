//
//  UICollectionView+Extension.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

extension UICollectionView {
  func configureMoreToolCollectionView() -> UICollectionViewDiffableDataSource<ToolSection, Tool> {
    register(ConverterToolCell.self, forCellWithReuseIdentifier: ConverterToolCell.reuseIdentifier)
    register(
      HeaderReusableView.self,
      forSupplementaryViewOfKind: HeaderReusableView.reuseIdentifier,
      withReuseIdentifier: HeaderReusableView.reuseIdentifier
    )

    collectionViewLayout = UICollectionViewCompositionalLayout.createCompositionalLayoutForMoreTool()
    let dataSource = UICollectionViewDiffableDataSource<ToolSection, Tool>.createMoreToolDataSource(for: self)
    UICollectionViewDiffableDataSource<ToolSection, Tool>.reloadDataForMoreTool(forDataSource: dataSource)

    return dataSource
  }
}
