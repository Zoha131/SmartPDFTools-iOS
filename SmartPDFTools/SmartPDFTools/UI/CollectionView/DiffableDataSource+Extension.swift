//
//  DiffableDataSource+Extension.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

extension UICollectionViewDiffableDataSource {
  static func createDataSource(
    for collectionView: UICollectionView
  ) -> UICollectionViewDiffableDataSource<ToolSection, Tool> {
    let dataSource = UICollectionViewDiffableDataSource<ToolSection, Tool>(
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

    dataSource.supplementaryViewProvider = {(
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

    return dataSource
  }

  static func createMoreToolDataSource(
    for collectionView: UICollectionView
  ) -> UICollectionViewDiffableDataSource<ToolSection, Tool> {
    let dataSource = UICollectionViewDiffableDataSource<ToolSection, Tool>(
      collectionView: collectionView
    ) { collectionView, indexPath, tool in
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ConverterToolCell.reuseIdentifier,
        for: indexPath
        ) as? ConverterToolCell else {
          fatalError("Unable to dequeue")
      }

      cell.tool = tool

      return cell
    }

    dataSource.supplementaryViewProvider = {(
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

      headerSuplementary.label.text = "More Tools"

      return headerSuplementary
    }

    return dataSource
  }

  static func reloadDataForMoreTool(forDataSource dataSource: UICollectionViewDiffableDataSource<ToolSection, Tool>) {
    var snapshot = NSDiffableDataSourceSnapshot<ToolSection, Tool>()
    snapshot.appendSections([.txt])

    guard let tools = Tool.allToolMap[.txt] else {
      fatalError("Tools not found for section ")
    }

    snapshot.appendItems(tools)

    dataSource.apply(snapshot)
  }
}
