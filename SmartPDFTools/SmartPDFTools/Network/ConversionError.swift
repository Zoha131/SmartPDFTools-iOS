//
//  ServerError.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/17/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation

struct ConversionError: Error {
  let cause: String
  var localizedDescription: String { cause }
}
