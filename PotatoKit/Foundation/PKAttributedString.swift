//
//  PKAttributedString.swift
//  PotatoKit
//
//  Created by IT on 02/10/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation


extension NSAttributedString {
    
    /// 将html文本转换成富文本
    ///
    /// - Parameter string: html字符串
    /// - Returns: NSAttributedString
    /// - Throws: <#throws value description#>
    public static func attributedString(html string: String) throws -> NSAttributedString? {
        guard let data = string.data(using: String.Encoding.unicode) else { return nil }
        
        return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
}
