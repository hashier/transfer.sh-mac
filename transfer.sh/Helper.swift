//
//  Helper.swift
//  transfer.sh
//
//  Created by Christopher Loessl on 2016-10-20.
//  Copyright © 2016 chl. All rights reserved.
//

import Foundation

class Helper {

    class func isDir() -> Bool? {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let fullPath = URL(string: "")?.path
        if fileManager.fileExists(atPath: fullPath!, isDirectory:&isDir) {
            if isDir.boolValue {
                return true
            } else {
                return false
            }
        } else {
            return nil
        }
    }

}
