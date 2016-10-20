//
//  MIME.swift
//  transfer.sh
//
//  Created by Christopher Loessl on 2016-10-16.
//  Copyright © 2016 chl. All rights reserved.
//

import Foundation

class MIME {
    class func MIMEType(fileExtension: String) -> String? {
        guard !fileExtension.isEmpty else {
            return nil
        }

        var mimeType: String? = nil

        let UTIRef = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as CFString, nil)
        let UTI = UTIRef?.takeUnretainedValue()
        UTIRef?.release()

        let MIMETypeRef = UTTypeCopyPreferredTagWithClass(UTI!, kUTTagClassMIMEType)
        if MIMETypeRef != nil {
            let MIMEType = MIMETypeRef?.takeUnretainedValue()
            MIMETypeRef?.release()
            mimeType = MIMEType as? String
        }
        return mimeType
    }
    
}
