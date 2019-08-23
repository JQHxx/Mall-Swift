//
//  UIColorExtension.swift
//  Mall
//
//  Created by midland on 2019/8/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    static func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
}
