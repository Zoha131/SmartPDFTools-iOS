//
//  RestService.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/17/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation
import Combine

class RestService: NSObject {
  private lazy var session: URLSession = {
    URLSession(configuration: .default, delegate: self, delegateQueue: .main)
  }()

  private lazy var restManager: RestManager = {
    RestManager(session: self.session)
  }()

  private let uploadURL: URL
  let decoder = JSONDecoder()

  var onDownloadCompleted: ((Result<URL, ConversionError>) -> Void)?
  var onUploadCompleted: ((Result<String, ConversionError>) -> Void)?

  private var contentLength: Int64 = 1
  @Published private(set) var taskProgress: Float = 0

  override init() {
    guard let url = URL(string: "https://pdftoworder.com/api/convert") else {
      fatalError("Upload URL is not correct")
    }

    uploadURL = url
  }

  func uploadSingleFile(fileURL: URL, tool: Tool) {
    guard fileURL.startAccessingSecurityScopedResource() else {
      fatalError("Unable to open file")
    }

    defer {
      fileURL.stopAccessingSecurityScopedResource()
    }

    let fileInfo = RestManager.FileInfo(
      withFileURL: fileURL,
      filename: fileURL.lastPathComponent,
      // TODO: Some tool can have multiple files.
      // I will add this shortly. Currenlty using
      // this so that app can work with all the tools.
      name: tool.supportMultipleInput ? "input[0]" : "input",
      mimetype: fileURL.mimeType()
    )

    restManager.httpBodyParameters.add(value: "k4xeEyhI2QRHlGCGaNl7c3feRDZY690", forKey: "api_key")
    restManager.httpBodyParameters.add(value: tool.toolID, forKey: "tool_uid")
    upload(files: [fileInfo])
  }

  private func upload(files: [RestManager.FileInfo]) {
    restManager.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { results, failedFilesList in
      if let error = results.error {
        self.onUploadCompleted?(.failure(ConversionError(cause: error.localizedDescription)))
      }

      if let data = results.data {
        do {
          let result = try self.decoder.decode(ConversionResult.self, from: data)

          if let downloadURL = result.downloadURL {
            self.onUploadCompleted?(.success(downloadURL))
          } else {
            self.onUploadCompleted?(.failure(ConversionError(cause: result.message)))
          }
        } catch let error {
          self.onUploadCompleted?(.failure(ConversionError(cause: error.localizedDescription)))
        }
      }

      if failedFilesList != nil {
        self.onUploadCompleted?(.failure(ConversionError(cause: "File can't be accessed")))
      }
    }
  }

  func download(url downloadURL: String) {
    if let remoteURL = URL(string: downloadURL) {
      var request = URLRequest(url: remoteURL)
      request.httpMethod = "GET"

      let task = session.downloadTask(with: request)
      task.resume()
    } else {
      onDownloadCompleted?(.failure(ConversionError(cause: "Could not initiate the request")))
    }
  }
}

extension RestService: URLSessionDownloadDelegate {
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
      let downloadURL = downloadTask.currentRequest?.url {
      let localURL = documentDirectory.appendingPathComponent("/\(downloadURL.lastPathComponent)")

      do {
        try FileManager.default.copyItem(at: location, to: localURL)
        onDownloadCompleted?(.success(localURL))
      } catch let copyError {
        onDownloadCompleted?(.failure(ConversionError(cause: copyError.localizedDescription)))
      }
    } else {
      onDownloadCompleted?(.failure(ConversionError(cause: "File Could not be saved")))
    }
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if task is URLSessionDownloadTask,
      let error = error {
      onDownloadCompleted?(.failure(ConversionError(cause: error.localizedDescription)))
    }
  }

  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64
  ) {
    let downloadProgress = Float(totalBytesWritten) / Float(contentLength)
    //Currently server does not provide "Content-Length" in headers
    //That's why `totalBytesExpectedToWrite` is alway -1
    //To show the progress I am storing the upload file size and
    //calculating with the stored value.
    if downloadProgress < 1.0 {
      taskProgress = downloadProgress
    } else {
      taskProgress = Float.random(in: 0.8...0.95)
    }
  }

  func urlSession (
    _ session: URLSession,
    task: URLSessionTask,
    didSendBodyData bytesSent: Int64,
    totalBytesSent: Int64,
    totalBytesExpectedToSend: Int64
  ) {
    let uploadProgress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
    // Currently Server taking some time to convert the file after uploading
    // User might get frustrated to wait after seeing 100% complete
    // That's why for better user satisfaction I am reducing the parcentage
    let helper = Float.random(in: 0...0.09)
    taskProgress = uploadProgress - helper
    contentLength = totalBytesExpectedToSend
  }
}
