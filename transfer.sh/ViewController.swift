//
//  ViewController.swift
//  transfer.sh
//
//  Created by Christopher Loessl on 2016-10-14.
//  Copyright © 2016 chl. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var dragToView: DestinationView! {
        didSet {
            dragToView.delegate = self
        }
    }
    @IBOutlet private weak var destinationView: DestinationView!
    @IBOutlet internal weak var linkTextField: NSTextField!
    @IBOutlet internal weak var progressTextField: NSTextField! {
        didSet {
            progressTextField.stringValue = "Upload not yet started"
        }
    }

    internal var responseData = Data()

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
            print(representedObject ?? "hashier: debug")
        }
    }

}

// MARK: - DestinationViewDelegate
extension ViewController: DestinationViewDelegate {

    func processFileURLs(_ urls: [URL]) {
        for (index, url) in urls.enumerated() {
            print("hashier: num: \(index) url: \(url)")
        }
        guard let url = urls.first, urls.count == 1 else {
            print("Only one URL supported for now")
            progressTextField.stringValue = "Upload not yet started"
            return
        }
        uploadFile(url)
    }

    private func uploadFile(_ fileToUpload: URL) {
        let test = UploadFile(withDelegate: self)
        test.upload(fileToUpload)
    }

}

// MARK: - URLSessionTaskDelegate
extension ViewController: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let percentage = (Double(totalBytesSent) / Double(totalBytesExpectedToSend)) * 100
        print(String(format: "Uploaded: %d, which is %.2f%", totalBytesSent, percentage))
        DispatchQueue.main.async {
            self.progressTextField.stringValue = String(format: "Uploaded: %d bytes, which is %.2f%%", totalBytesSent, percentage)
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let string = String(data: responseData, encoding: String.Encoding.utf8) {
            print(string)
            DispatchQueue.main.async {
                self.linkTextField.stringValue = string
            }
        }
        responseData = Data()
    }
}

// MARK: - URLSessionDataDelegate
extension ViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
    }
}
