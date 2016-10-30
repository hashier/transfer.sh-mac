//
//  UploadFile.swift
//  transfer.sh
//
//  Created by Christopher Loessl on 2016-10-14.
//  Copyright © 2016 chl. All rights reserved.
//

import Foundation
import CoreServices

let uploadURLString = "https://transfer.sh/"

class UploadFile {
    init(withDelegate delegate: URLSessionDelegate?) {
        defaultSession = URLSession(configuration: URLSessionConfiguration.default, delegate: delegate, delegateQueue: nil)
    }
    var defaultSession: URLSession
    var dataTask: URLSessionUploadTask?

    func upload(_ fileToUpload: URL) {
        if dataTask != nil {
            dataTask?.cancel()
        }

        let pe = fileToUpload.pathExtension
        let fn = fileToUpload.lastPathComponent

        var urlComponents = URLComponents(string: uploadURLString)!
        urlComponents.path = "/".appending(fn)
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let pathExt = MIME.MIMEType(fileExtension: pe) {
            request.addValue(pathExt, forHTTPHeaderField: "Content-Type")
        }
        request.httpMethod = "PUT"

        dataTask = defaultSession.uploadTask(with: request, fromFile: fileToUpload)

        dataTask?.resume()
    }

}
