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
  var rest = RestManager()
  var selectedURLFile: URL?
  var downloadURL: String = "https://pdftoworder.com/download/60X8tCdr0ienj6p20t/47429342-sampletext-txt.pdf"
  var isDownloaded = false
  var localDownlaodedURL: URL?

  override func viewDidLoad() {
    super.viewDidLoad()

    rest.delegate = self
    chooserCardView.layer.addSublayer(borderLayer)
    borderLayer.updateBorderLayer(with: chooserCardView.bounds)

    dataSource = collectionView.configureMoreToolCollectionView()
    sponsoreView.updateVisibility()

    selectionView.setInside(into: chooserCardView)

    selectionView.onDeviceAction = {
      let importMenu = UIDocumentPickerViewController(documentTypes: [kUTTypeText as String], in: .open)
      importMenu.delegate = self
      importMenu.modalPresentationStyle = .formSheet
      self.present(importMenu, animated: true, completion: nil)
    }

    selectionView.onDropboxAction = {
      self.moveForward(from: self.selectionView, to: self.uploadView)
    }

    uploadView.onUploadAction = {
      self.moveForward(from: self.uploadView, to: self.progressView)
      self.progressView.configureViews(withColor: .txtTopdf, animation: "upload_two")
      guard let url = self.selectedURLFile else {
        fatalError("Url can't be nil at this stage")
      }

      self.uploadSingleFile(fileURL: url)
    }

    progressView.onCancelAction = {
      if self.isDownloaded {
        self.viewPDF()
      }
    }

    completeView.onDownloadAction = {
      self.download()
      self.moveForward(from: self.completeView, to: self.progressView)
      self.progressView.titleView.text = "Downloading"
      self.progressView.configureViews(withColor: .txtTopdf, animation: "download_one")
    }

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
      uploadView.configureViews(withColor: .txtTopdf, image: .txtTopdf, fileName: url.lastPathComponent)

      selectedURLFile = url
    }
  }
}

extension SelectionViewController: URLSessionTaskDelegate {
  func urlSession (
    _ session: URLSession,
    task: URLSessionTask,
    didSendBodyData bytesSent: Int64,
    totalBytesSent: Int64,
    totalBytesExpectedToSend: Int64
  ) {
    let uploadProgress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
    print("\(uploadProgress)")
    progressView.setProgress(uploadProgress)
  }

  func uploadSingleFile(fileURL: URL) {
    guard fileURL.startAccessingSecurityScopedResource() else {
      fatalError("Unable to open file")
    }

    defer {
      fileURL.stopAccessingSecurityScopedResource()
    }

    let fileInfo = RestManager.FileInfo(
      withFileURL: fileURL,
      filename: "sampleText.txt",
      name: "input",
      mimetype: "text/plain"
    )

    rest.httpBodyParameters.add(value: "DzkpCKjktggtCT1ZE8bFqca7anmmkpOcg975", forKey: "api_key")
    rest.httpBodyParameters.add(value: "PR19", forKey: "tool_uid")
    upload(files: [fileInfo], toURL: URL(string: "https://pdftoworder.com/api/convert"))
  }

  func upload(files: [RestManager.FileInfo], toURL url: URL?) {
    if let uploadURL = url {
      rest.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { results, failedFilesList in
        print("HTTP status code:", results.response?.httpStatusCode ?? 0)

        if let error = results.error {
          print(error)
        }

        if let data = results.data {
          if let toDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            self.moveForward(from: self.progressView, to: self.completeView)
            self.completeView.configureViews(withColor: .txtTopdf)
            print(toDictionary)
          }
        }

        if let failedFiles = failedFilesList {
          for file in failedFiles {
            print(file)
          }
        }
      }
    }
  }

  func download() {
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
      let remoteURL = URL(string: downloadURL) {
        let localURL = documentDirectory.appendingPathComponent("/" + "474336-sampletexrrt-txt.pdf")

        let urlSessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: urlSessionConfig, delegate: self, delegateQueue: .main)
        var request = URLRequest(url: remoteURL)
        request.httpMethod = "GET"

        let task = session.downloadTask(with: request) { tempLocalURL, _, error in
          if let tempLocalURL = tempLocalURL, error == nil {
            do {
              try FileManager.default.copyItem(at: tempLocalURL, to: localURL)
              self.localDownlaodedURL = localURL
              self.progressView.button.applyButtonShadow(withBackgroundColor: .txtTopdf)
              self.progressView.progressBar.setProgress(1, animated: true)
              self.progressView.progressTxt.text = "Downlaod Completed"
              self.progressView.button.setTitle("View", for: .normal)
              self.isDownloaded = true
            } catch {
              print("Download Failed")
            }
          }
        }

        task.resume()
    }
  }
}

extension SelectionViewController: QLPreviewControllerDataSource {

  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    1
  }

  func previewController(
    _ controller: QLPreviewController,
    previewItemAt index: Int
  ) -> QLPreviewItem {
    localDownlaodedURL as! NSURL
  }

  func viewPDF() {
    let quickLookViewController = QLPreviewController()
    quickLookViewController.dataSource = self
    present(quickLookViewController, animated: true)
  }
}
