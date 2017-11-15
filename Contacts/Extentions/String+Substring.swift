//
//  String+Substring.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/15/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import Foundation

extension String {

    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
