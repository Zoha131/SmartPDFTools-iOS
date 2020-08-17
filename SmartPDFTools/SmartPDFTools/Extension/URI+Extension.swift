//
//  URI+Extension.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/17/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation
import MobileCoreServices

extension URL {
  func mimeType() -> String {
      let pathExtension = self.pathExtension
      if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
          if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
              return mimetype as String
          }
      }
      return "application/octet-stream"
  }
}
