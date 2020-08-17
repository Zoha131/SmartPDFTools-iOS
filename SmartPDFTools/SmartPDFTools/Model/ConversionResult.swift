//
//  ConversionResult.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/17/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation

struct ConversionResult: Codable {
  let message: String
  let downloadURL: String?
  let success: Bool

  enum CodingKeys: String, CodingKey {
    case message = "msg"
    case downloadURL = "output-link"
    case success
  }
}
