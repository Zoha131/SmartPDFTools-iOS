//
//  SelectionViewController.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/13/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit
import MobileCoreServices
import QuickLook
import Combine

class SelectionViewController: UIViewController {
  @IBOutlet weak var chooserCardView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var sponsoreView: UIImageView!

  let borderLayer: CAShapeLayer = .createBorderLayer()
  var dataSource: UICollectionViewDiffableDataSource<ToolSection, Tool>?

  let selectionView = SelectionView.fromNib()
  let uploadView = UploadView.fromNib()
  let progressView = ProgressView.fromNib()
  let completeView = CompleteView.fromNib()

  // swiftlint:disable:next implicitly_unwrapped_optional
  var tool: Tool!
  lazy var service = RestService()
  var selectedURLFile: URL?
  var downloadURL: String?
  var localDownlaodedURL: URL?

  var cancellables: Set<AnyCancellable> = []

  override func viewDidLoad() {
    super.viewDidLoad()

    chooserCardView.layer.addSublayer(borderLayer)
    borderLayer.updateBorderLayer(with: chooserCardView.bounds)

    dataSource = collectionView.configureMoreToolCollectionView()
    sponsoreView.updateVisibility()

    selectionView.setInside(into: chooserCardView)

    selectionView.onDeviceAction = {
      let importMenu = UIDocumentPickerViewController(documentTypes: [self.tool.documentType as String], in: .open)
      importMenu.delegate = self
      importMenu.modalPresentationStyle = .formSheet
      self.present(importMenu, animated: true, completion: nil)
    }

    selectionView.onDropboxAction = {
      self.moveForward(from: self.selectionView, to: self.uploadView)
    }

    uploadView.onUploadAction = {
      self.uploadFile()
    }

    progressView.onCancelAction = {

    }

    completeView.onDownloadAction = {
      if self.localDownlaodedURL != nil {
        self.viewPDF()
      }else{
        self.downloadFile()
      }
    }

    service.onUploadCompleted = { (result: Result<String, ConversionError>) in
      switch result {
      case .success(let downloadURL):
        self.downloadURL = downloadURL
        self.moveForward(from: self.progressView, to: self.completeView)
        self.completeView.configureViews(withColor: self.tool.color, title: "Upload Completed", buttonTitle: "Download")
      case .failure(let error):
        print(error.localizedDescription)
      }
    }

    service.onDownloadCompleted = { (result: Result<URL, ConversionError>) in
      switch result {
      case .success( let fileURL):
        self.localDownlaodedURL = fileURL
        self.moveForward(from: self.progressView, to: self.completeView)
        self.completeView.configureViews(withColor: self.tool.color, title: "Download Completed", buttonTitle: "View")
      case .failure(let error):
        print(error.localizedDescription)
      }
    }

    service.$taskProgress.sink { progress in
      self.progressView.setProgress(progress)
    }.store(in: &cancellables)

    title = tool.title
  }

  func moveForward(from viewFrom: UIView, to viewTo: UIView) {
    viewTo.setInside(into: self.chooserCardView)
    viewTo.alpha = 0.0

    UIView.animate(withDuration: 0.4) {
      viewTo.alpha = 1.0
    }

    UIView.animate(
      withDuration: 0.8,
      animations: {
        viewFrom.alpha = 0.0
      }, completion: { _ in
        viewFrom.removeFromSuperview()
      }
    )
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    borderLayer.updateBorderLayer(with: chooserCardView.bounds)
    sponsoreView.updateVisibility()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    borderLayer.updateBorderLayer(with: chooserCardView.bounds)
  }
}

extension SelectionViewController: UIDocumentPickerDelegate {
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    if let url = urls.first {
      moveForward(from: selectionView, to: uploadView)
      uploadView.configureViews(withColor: tool.color, image: tool.image, fileName: url.lastPathComponent)

      selectedURLFile = url
    }
  }
}

extension SelectionViewController {
  func uploadFile() {
    guard let fileURL = selectedURLFile else {
      fatalError("Url can't be nil at this stage")
    }

    localDownlaodedURL = nil
    moveForward(from: uploadView, to: progressView)
    progressView.titleView.text = "Uploading"
    progressView.configureViews(withColor: tool.color, animation: "upload_two")

    service.uploadSingleFile(fileURL: fileURL, toolID: tool.toolID)
  }

  func downloadFile() {
    guard let downloadURL = downloadURL else {
      fatalError("Url can't be nil at this stage")
    }

    moveForward(from: completeView, to: progressView)
    progressView.titleView.text = "Downloading"
    progressView.configureViews(withColor: tool.color, animation: "download_one")

    service.download(url: downloadURL) 
  }
}

extension SelectionViewController: QLPreviewControllerDataSource {
  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    return 1
  }

  func previewController(
    _ controller: QLPreviewController,
    previewItemAt index: Int
  ) -> QLPreviewItem {
    guard let localDownlaodedURL = localDownlaodedURL else{
      fatalError("LocalDownloadURL Can't be null at this position")
    }

    return localDownlaodedURL as NSURL
  }

  func viewPDF() {
    let quickLookViewController = QLPreviewController()
    quickLookViewController.dataSource = self
    present(quickLookViewController, animated: true)
  }
}
