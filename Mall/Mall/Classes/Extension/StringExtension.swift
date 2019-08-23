//
//  StringExtension.swift
//  Mall
//
//  Created by midland on 2019/8/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

extension String {
    
    // 调整行间距
    public func lineSpace(_ lineSpace: CGFloat
        ) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStye = NSMutableParagraphStyle()
        
        paragraphStye.lineSpacing = lineSpace
        let range = NSRange(location: 0, length: CFStringGetLength(self as CFString?))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: range)
        return attributedString
    }
}
