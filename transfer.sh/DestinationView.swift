//
//  DestinationView.swift
//  transfer.sh
//
//  Created by Christopher Loessl on 2016-10-16.
//  Copyright © 2016 chl. All rights reserved.
//

import Foundation
import Cocoa

protocol DestinationViewDelegate {
    func processFileURLs(_ urls: [URL])
}

private let lineWidth: CGFloat = 6.0

class DestinationView: NSView {

    private var isReceivingDrag = false {
        didSet {
            needsDisplay = true
        }
    }
    var delegate: DestinationViewDelegate?

    private var acceptedTypes = [kUTTypeFileURL as String]
    // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/PasteboardGuide106/Articles/pbReading.html
    private lazy var filteringOptions = [NSPasteboardURLReadingFileURLsOnlyKey : true]

    override func awakeFromNib() {
        setup()
    }

    private func setup() {
        self.register(forDraggedTypes: acceptedTypes)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if isReceivingDrag {
            NSColor.selectedControlColor.set()
            let path = NSBezierPath(rect: bounds)
            path.lineWidth = lineWidth
            path.stroke()
        }
    }

    private func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        var canAccept = false
        let pasteBoard = draggingInfo.draggingPasteboard()
        if pasteBoard.canReadObject(forClasses: [NSURL.self], options: filteringOptions) {
            canAccept = true
        }

        return canAccept
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = shouldAllowDrag(sender)
        isReceivingDrag = allow
        return allow ? .copy : NSDragOperation()
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        isReceivingDrag = false
    }

    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
        isReceivingDrag = false
        let pasteBoard = draggingInfo.draggingPasteboard()

        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: filteringOptions) as? [URL], !urls.isEmpty {
            delegate?.processFileURLs(urls)

            return true
        }

        return false
    }



}
