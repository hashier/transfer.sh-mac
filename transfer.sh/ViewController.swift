//
//  ViewController.swift
//  transfer.sh
//
//  Created by Christopher Loessl on 2016-10-14.
//  Copyright © 2016 chl. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet private weak var destinationView: DestinationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        destinationView.delegate = self

        let test = UploadFile()
        test.upload()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            print(representedObject ?? "")
        }
    }

}

// MARK: - DestinationViewDelegate
extension ViewController: DestinationViewDelegate {

    func processFileURLs(_ urls: [URL]) {
        for (index, url) in urls.enumerated() {
            print("hashier: num: \(index) url: \(url)")
        }
    }

    func processFile(_ image: NSImage) {

    }

}
