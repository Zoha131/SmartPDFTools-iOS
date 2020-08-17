//
//  RestService.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/17/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation

class RestService {
  private let restManager: RestManager
  private let session: URLSession
  private let uploadURL: URL
  let decoder = JSONDecoder()

  init(delegate taskDelegate: URLSessionTaskDelegate) {
    let sessionConfiguration = URLSessionConfiguration.default
    session = URLSession(configuration: sessionConfiguration, delegate: taskDelegate, delegateQueue: .main)
    restManager = RestManager(session: session)

    guard let url = URL(string: "https://pdftoworder.com/api/convert") else {
      fatalError("Upload URL is not correct")
    }

    uploadURL = url
  }

  func uploadSingleFile(fileURL: URL, toolID: String, completion: @escaping(_ result: Result<String, Error>) -> Void) {
    guard fileURL.startAccessingSecurityScopedResource() else {
      fatalError("Unable to open file")
    }

    defer {
      fileURL.stopAccessingSecurityScopedResource()
    }

    let fileInfo = RestManager.FileInfo(
      withFileURL: fileURL,
      filename: fileURL.lastPathComponent,
      name: "input",
      mimetype: fileURL.mimeType()
    )

    restManager.httpBodyParameters.add(value: "k4xeEyhI2QRHlGCGaNl7c3feRDZY690", forKey: "api_key")
    restManager.httpBodyParameters.add(value: toolID, forKey: "tool_uid")
    upload(files: [fileInfo], completion: completion)
  }

  private func upload(files: [RestManager.FileInfo], completion: @escaping(_ result: Result<String, Error>) -> Void) {
    restManager.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { results, failedFilesList in
      if let error = results.error {
        completion(.failure(ConversionError(cause: error.localizedDescription)))
      }

      if let data = results.data {
        do {
          let result = try self.decoder.decode(ConversionResult.self, from: data)

          if let downloadURL = result.downloadURL {
            completion(.success(downloadURL))
          } else{
            completion(.failure(ConversionError(cause: result.message)))
          }
        } catch let error {
          completion(.failure(ConversionError(cause: error.localizedDescription)))
        }
      }

      if failedFilesList != nil {
        completion(.failure(ConversionError(cause: "File can't be accessed")))
      }
    }
  }

  func download(url downloadURL: String, completion: @escaping(_ result: Result<URL, Error>) -> Void) {
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
      let remoteURL = URL(string: downloadURL) {
      let localURL = documentDirectory.appendingPathComponent("/\(remoteURL.lastPathComponent)")

       var request = URLRequest(url: remoteURL)
        request.httpMethod = "GET"

        let task = session.downloadTask(with: request) { tempLocalURL, _, error in
          if let tempLocalURL = tempLocalURL, error == nil {
            do {
              try FileManager.default.copyItem(at: tempLocalURL, to: localURL)
              completion(.success(localURL))
            } catch let copyError {
              completion(.failure(ConversionError(cause: copyError.localizedDescription)))
            }
          } else {
            completion(.failure(ConversionError(cause: error?.localizedDescription ?? "Temp Local URL Error")))
          }
        }
        task.resume()
    } else {
      completion(.failure(ConversionError(cause: "Could not initiate the request")))
    }
  }
}
