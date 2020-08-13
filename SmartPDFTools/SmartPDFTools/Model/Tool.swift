//
//  Tool.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/12/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

struct Tool: Hashable {
  let image: UIImage
  let color: UIColor
  let title: String
  let uniqueInt: Int
}
// swiftlint:disable all
extension Tool {
  static let bmpTopdf       = Tool(image: UIImage.bmpTopdf,      color: UIColor.bmpTopdf,      title: String.bmpTopdf,      uniqueInt: Int.random(in: 1...9999))
  static let bmpTotxt       = Tool(image: UIImage.bmpTotxt,      color: UIColor.bmpTotxt,      title: String.bmpTotxt,      uniqueInt: Int.random(in: 1...9999))
  static let bmpTotxt2      = Tool(image: UIImage.bmpTotxt,      color: UIColor.bmpTotxt,      title: String.bmpTotxt,      uniqueInt: Int.random(in: 1...9999))
  static let compresspdf    = Tool(image: UIImage.compresspdf,   color: UIColor.compresspdf,   title: String.compresspdf,   uniqueInt: Int.random(in: 1...9999))
  static let decryptpdf     = Tool(image: UIImage.decryptpdf,    color: UIColor.decryptpdf,    title: String.decryptpdf,    uniqueInt: Int.random(in: 1...9999))
  static let encryptpdf     = Tool(image: UIImage.encryptpdf,    color: UIColor.encryptpdf,    title: String.encryptpdf,    uniqueInt: Int.random(in: 1...9999))
  static let excelTopdf     = Tool(image: UIImage.excelTopdf,    color: UIColor.excelTopdf,    title: String.excelTopdf,    uniqueInt: Int.random(in: 1...9999))
  static let extractImages  = Tool(image: UIImage.extractImages, color: UIColor.extractImages, title: String.extractImages, uniqueInt: Int.random(in: 1...9999))
  static let htmlTopdf      = Tool(image: UIImage.htmlTopdf,     color: UIColor.htmlTopdf,     title: String.htmlTopdf,     uniqueInt: Int.random(in: 1...9999))
  static let jpgTotxt       = Tool(image: UIImage.jpgTotxt,      color: UIColor.jpgTotxt,      title: String.jpgTotxt,      uniqueInt: Int.random(in: 1...9999))
  static let jpgTotxt2      = Tool(image: UIImage.jpgTotxt,      color: UIColor.jpgTotxt,      title: String.jpgTotxt,      uniqueInt: Int.random(in: 1...9999))
  static let jpgTopdf       = Tool(image: UIImage.jpgTopdf,      color: UIColor.jpgTopdf,      title: String.jpgTopdf,      uniqueInt: Int.random(in: 1...9999))
  static let mergpdf        = Tool(image: UIImage.mergpdf,       color: UIColor.mergpdf,       title: String.mergpdf,       uniqueInt: Int.random(in: 1...9999))
  static let pdfTobmp       = Tool(image: UIImage.pdfTobmp,      color: UIColor.pdfTobmp,      title: String.pdfTobmp,      uniqueInt: Int.random(in: 1...9999))
  static let pdfTohtml      = Tool(image: UIImage.pdfTohtml,     color: UIColor.pdfTohtml,     title: String.pdfTohtml,     uniqueInt: Int.random(in: 1...9999))
  static let pdfTojpg       = Tool(image: UIImage.pdfTojpg,      color: UIColor.pdfTojpg,      title: String.pdfTojpg,      uniqueInt: Int.random(in: 1...9999))
  static let pdfTopng       = Tool(image: UIImage.pdfTopng,      color: UIColor.pdfTopng,      title: String.pdfTopng,      uniqueInt: Int.random(in: 1...9999))
  static let pdfToppt       = Tool(image: UIImage.pdfToppt,      color: UIColor.pdfToppt,      title: String.pdfToppt,      uniqueInt: Int.random(in: 1...9999))
  static let pdfTops        = Tool(image: UIImage.pdfTops,       color: UIColor.pdfTops,       title: String.pdfTops,       uniqueInt: Int.random(in: 1...9999))
  static let pdfTotiff      = Tool(image: UIImage.pdfTotiff,     color: UIColor.pdfTotiff,     title: String.pdfTotiff,     uniqueInt: Int.random(in: 1...9999))
  static let pdfTotxt       = Tool(image: UIImage.pdfTotxt,      color: UIColor.pdfTotxt,      title: String.pdfTotxt,      uniqueInt: Int.random(in: 1...9999))
  static let pdfToword      = Tool(image: UIImage.pdfToword,     color: UIColor.pdfToword,     title: String.pdfToword,     uniqueInt: Int.random(in: 1...9999))
  static let pngTopdf       = Tool(image: UIImage.pngTopdf,      color: UIColor.pngTopdf,      title: String.pngTopdf,      uniqueInt: Int.random(in: 1...9999))
  static let pngTotxt       = Tool(image: UIImage.pngTotxt,      color: UIColor.pngTotxt,      title: String.pngTotxt,      uniqueInt: Int.random(in: 1...9999))
  static let pngTotxt2      = Tool(image: UIImage.pngTotxt,      color: UIColor.pngTotxt,      title: String.pngTotxt,      uniqueInt: Int.random(in: 1...9999))
  static let pptTopdf       = Tool(image: UIImage.pptTopdf,      color: UIColor.pptTopdf,      title: String.pptTopdf,      uniqueInt: Int.random(in: 1...9999))
  static let rotatepdf      = Tool(image: UIImage.rotatepdf,     color: UIColor.rotatepdf,     title: String.rotatepdf,     uniqueInt: Int.random(in: 1...9999))
  static let splitpdf       = Tool(image: UIImage.splitpdf,      color: UIColor.splitpdf,      title: String.splitpdf,      uniqueInt: Int.random(in: 1...9999))
  static let tiffTopdf      = Tool(image: UIImage.tiffTopdf,     color: UIColor.tiffTopdf,     title: String.tiffTopdf,     uniqueInt: Int.random(in: 1...9999))
  static let tiffTotxt      = Tool(image: UIImage.tiffTotxt,     color: UIColor.tiffTotxt,     title: String.tiffTotxt,     uniqueInt: Int.random(in: 1...9999))
  static let tiffTotxt2     = Tool(image: UIImage.tiffTotxt,     color: UIColor.tiffTotxt,     title: String.tiffTotxt,     uniqueInt: Int.random(in: 1...9999))
  static let txtTopdf       = Tool(image: UIImage.txtTopdf,      color: UIColor.txtTopdf,      title: String.txtTopdf,      uniqueInt: Int.random(in: 1...9999))
  static let watermarkpdf   = Tool(image: UIImage.watermarkpdf,  color: UIColor.watermarkpdf,  title: String.watermarkpdf,  uniqueInt: Int.random(in: 1...9999))
  static let wordTopdf      = Tool(image: UIImage.wordTopdf,     color: UIColor.wordTopdf,     title: String.wordTopdf,     uniqueInt: Int.random(in: 1...9999))

  static let allToolMap: Dictionary<ToolSection, [Tool]> = [
    .pdf:         [.mergpdf,    .splitpdf,  .compresspdf, .watermarkpdf, .encryptpdf, .decryptpdf, .rotatepdf, .extractImages],
    .jpg:         [.pdfTojpg,   .jpgTopdf,  .jpgTotxt],
    .word:        [.pdfToword,  .wordTopdf],
    .txt:         [.pdfTotxt,   .txtTopdf,  .jpgTotxt2,   .tiffTotxt2,   .bmpTotxt2, .pngTotxt2],
    .png:         [.pdfTopng,   .pngTopdf,  .pngTotxt],
    .mega:        [.excelTopdf, .pdfTops],
    .html:        [.pdfTohtml,  .htmlTopdf],
    .tiff:        [.pdfTotiff,  .tiffTopdf, .tiffTotxt],
    .powerpoint:  [.pdfToppt,   .pptTopdf],
    .bmp:         [.pdfTobmp,   .bmpTopdf,  .bmpTotxt]
  ]
}
// swiftlint:enable all
