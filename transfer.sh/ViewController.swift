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
    @IBOutlet private weak var linkTextField: NSTextField!
    @IBOutlet internal weak var progressTextField: NSTextField! {
        didSet {
            progressTextField.stringValue = "Upload not yet started"
        }
    }

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
        let test = UploadFile()
        test.upload(fileToUpload)
    }

}
