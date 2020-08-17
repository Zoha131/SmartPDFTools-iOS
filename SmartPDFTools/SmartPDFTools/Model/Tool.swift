//
//  Tool.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/12/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit
import MobileCoreServices

struct Tool: Hashable {
  let image: UIImage
  let color: UIColor
  let title: String
  let uniqueInt: Int
  let toolID: String
  let documentType: CFString
  let supportMultipleInput: Bool
}
// swiftlint:disable all
// TODO: Change it to use json with codable
extension Tool {
  static let bmpTopdf      = Tool(image: UIImage.bmpTopdf,      color: UIColor.bmpTopdf,      title: String.bmpTopdf,      uniqueInt: 1, toolID: "PR24", documentType: kUTTypeBMP, supportMultipleInput: true)
  static let bmpTotxt      = Tool(image: UIImage.bmpTotxt,      color: UIColor.bmpTotxt,      title: String.bmpTotxt,      uniqueInt: 2, toolID: "PR28", documentType: kUTTypeBMP, supportMultipleInput: false)
  static let bmpTotxt2     = Tool(image: UIImage.bmpTotxt,      color: UIColor.bmpTotxt,      title: String.bmpTotxt,      uniqueInt: 3, toolID: "PR28", documentType: kUTTypeBMP, supportMultipleInput: false)
  static let compresspdf   = Tool(image: UIImage.compresspdf,   color: UIColor.compresspdf,   title: String.compresspdf,   uniqueInt: 4, toolID: "PR29", documentType: kUTTypePDF, supportMultipleInput: false)
  static let decryptpdf    = Tool(image: UIImage.decryptpdf,    color: UIColor.decryptpdf,    title: String.decryptpdf,    uniqueInt: 5, toolID: "PR12", documentType: kUTTypePDF, supportMultipleInput: false)
  static let encryptpdf    = Tool(image: UIImage.encryptpdf,    color: UIColor.encryptpdf,    title: String.encryptpdf,    uniqueInt: 6, toolID: "PR11", documentType: kUTTypePDF, supportMultipleInput: false)
  static let excelTopdf = Tool(image: UIImage.excelTopdf,    color: UIColor.excelTopdf,    title: String.excelTopdf,    uniqueInt: 7, toolID: "PR3", documentType: kUTTypeSpreadsheet, supportMultipleInput: false)
  static let extractImages = Tool(image: UIImage.extractImages, color: UIColor.extractImages, title: String.extractImages, uniqueInt: 8, toolID: "PR15", documentType: kUTTypePDF, supportMultipleInput: false)
  static let htmlTopdf     = Tool(image: UIImage.htmlTopdf,     color: UIColor.htmlTopdf,     title: String.htmlTopdf,     uniqueInt: 9, toolID: "PR20", documentType: kUTTypeHTML, supportMultipleInput: false)
  static let jpgTotxt      = Tool(image: UIImage.jpgTotxt,      color: UIColor.jpgTotxt,      title: String.jpgTotxt,      uniqueInt: 10, toolID: "PR25", documentType: kUTTypeJPEG, supportMultipleInput: false)
  static let jpgTotxt2     = Tool(image: UIImage.jpgTotxt,      color: UIColor.jpgTotxt,      title: String.jpgTotxt,      uniqueInt: 11, toolID: "PR25", documentType: kUTTypeJPEG, supportMultipleInput: false)
  static let jpgTopdf      = Tool(image: UIImage.jpgTopdf,      color: UIColor.jpgTopdf,      title: String.jpgTopdf,      uniqueInt: 12, toolID: "PR21", documentType: kUTTypeJPEG, supportMultipleInput: true)
  static let mergpdf       = Tool(image: UIImage.mergpdf,       color: UIColor.mergpdf,       title: String.mergpdf,       uniqueInt: 13, toolID: "PR13", documentType: kUTTypePDF, supportMultipleInput: true)
  static let pdfTobmp      = Tool(image: UIImage.pdfTobmp,      color: UIColor.pdfTobmp,      title: String.pdfTobmp,      uniqueInt: 14, toolID: "PR9", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfTohtml     = Tool(image: UIImage.pdfTohtml,     color: UIColor.pdfTohtml,     title: String.pdfTohtml,     uniqueInt: 15, toolID: "PR4", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfTojpg      = Tool(image: UIImage.pdfTojpg,      color: UIColor.pdfTojpg,      title: String.pdfTojpg,      uniqueInt: 16, toolID: "PR8", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfTopng      = Tool(image: UIImage.pdfTopng,      color: UIColor.pdfTopng,      title: String.pdfTopng,      uniqueInt: 17, toolID: "PR6", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfToppt      = Tool(image: UIImage.pdfToppt,      color: UIColor.pdfToppt,      title: String.pdfToppt,      uniqueInt: 18, toolID: "PR17", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfTops       = Tool(image: UIImage.pdfTops,       color: UIColor.pdfTops,       title: String.pdfTops,       uniqueInt: 19, toolID: "PR18", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfTotiff     = Tool(image: UIImage.pdfTotiff,     color: UIColor.pdfTotiff,     title: String.pdfTotiff,     uniqueInt: 20, toolID: "PR7", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfTotxt      = Tool(image: UIImage.pdfTotxt,      color: UIColor.pdfTotxt,      title: String.pdfTotxt,      uniqueInt: 21, toolID: "PR5", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pdfToword     = Tool(image: UIImage.pdfToword,     color: UIColor.pdfToword,     title: String.pdfToword,     uniqueInt: 22, toolID: "PR16", documentType: kUTTypePDF, supportMultipleInput: false)
  static let pngTopdf      = Tool(image: UIImage.pngTopdf,      color: UIColor.pngTopdf,      title: String.pngTopdf,      uniqueInt: 23, toolID: "PR22", documentType: kUTTypePNG, supportMultipleInput: true)
  static let pngTotxt      = Tool(image: UIImage.pngTotxt,      color: UIColor.pngTotxt,      title: String.pngTotxt,      uniqueInt: 24, toolID: "PR26", documentType: kUTTypePNG, supportMultipleInput: false)
  static let pngTotxt2     = Tool(image: UIImage.pngTotxt,      color: UIColor.pngTotxt,      title: String.pngTotxt,      uniqueInt: 25, toolID: "PR26", documentType: kUTTypePNG, supportMultipleInput: false)
  static let pptTopdf = Tool(image: UIImage.pptTopdf,      color: UIColor.pptTopdf,      title: String.pptTopdf,      uniqueInt: 26, toolID: "PR2", documentType: kUTTypePresentation, supportMultipleInput: false)
  static let rotatepdf     = Tool(image: UIImage.rotatepdf,     color: UIColor.rotatepdf,     title: String.rotatepdf,     uniqueInt: 27, toolID: "PR10", documentType: kUTTypePDF, supportMultipleInput: false)
  static let splitpdf      = Tool(image: UIImage.splitpdf,      color: UIColor.splitpdf,      title: String.splitpdf,      uniqueInt: 28, toolID: "PR14", documentType: kUTTypePDF, supportMultipleInput: false)
  static let tiffTopdf     = Tool(image: UIImage.tiffTopdf,     color: UIColor.tiffTopdf,     title: String.tiffTopdf,     uniqueInt: 29, toolID: "PR23", documentType: kUTTypeTIFF, supportMultipleInput: true)
  static let tiffTotxt     = Tool(image: UIImage.tiffTotxt,     color: UIColor.tiffTotxt,     title: String.tiffTotxt,     uniqueInt: 30, toolID: "PR27", documentType: kUTTypeTIFF, supportMultipleInput: false)
  static let tiffTotxt2    = Tool(image: UIImage.tiffTotxt,     color: UIColor.tiffTotxt,     title: String.tiffTotxt,     uniqueInt: 31, toolID: "PR27", documentType: kUTTypeTIFF, supportMultipleInput: false)
  static let txtTopdf      = Tool(image: UIImage.txtTopdf,      color: UIColor.txtTopdf,      title: String.txtTopdf,      uniqueInt: 32, toolID: "PR19", documentType: kUTTypeText, supportMultipleInput: false)
  static let watermarkpdf  = Tool(image: UIImage.watermarkpdf,  color: UIColor.watermarkpdf,  title: String.watermarkpdf,  uniqueInt: 33, toolID: "PR30", documentType: kUTTypePDF, supportMultipleInput: false)
  static let wordTopdf     = Tool(image: UIImage.wordTopdf,     color: UIColor.wordTopdf,     title: String.wordTopdf,     uniqueInt: 34, toolID: "PR1", documentType: kUTTypeText, supportMultipleInput: false)

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
