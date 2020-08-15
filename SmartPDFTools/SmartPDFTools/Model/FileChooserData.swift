//
//  FileChooserData.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/14/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

struct FileChooserData: Hashable {
  let image: UIImage
  let title: String
  let imageSize: CGFloat
}

extension FileChooserData {
  static let all = [
    FileChooserData(image: .fromDropbox, title: "From Dropbox", imageSize: .fileChooserImageSize),
    FileChooserData(image: .fromDevice, title: "From Device", imageSize: .bigFileChooserImageSize),
    FileChooserData(image: .fromDrive, title: "From Drive", imageSize: .fileChooserImageSize)
  ]
}
