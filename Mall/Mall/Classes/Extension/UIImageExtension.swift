//
//  UIImageExtension.swift
//  Mall
//
//  Created by midland on 2019/8/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // MARK: - 图片压缩到指定的的大小
    func compressTo(kb: Int) -> UIImage {
        let afterCompress = compressToData(kb:kb)
        return UIImage(data: afterCompress) == nil ? self : UIImage(data: afterCompress)!
    }
    
    func compressToData(kb: Int) -> Data {
        guard kb > 0 else {
            return Data()
        }
        
        let fileSize = kb * 1024
        let maxCompression = CGFloat(0.1)
        var compression = CGFloat(0.9)
        var imageData = self.jpegData(compressionQuality: compression)
        // UIImageJPEGRepresentation(self, compression)
        if let limageData = imageData {
            var imageDataSize = MemoryLayout.stride(ofValue: limageData) * limageData.count
            while imageDataSize > fileSize && compression > maxCompression {
                compression -= 0.1
                imageData = self.jpegData(compressionQuality: compression)
                // UIImageJPEGRepresentation(self, compression)
                if let compressionImageData = imageData {
                    imageDataSize = compressionImageData.count
                }
            }
        }
        guard let afterCompress = imageData else {
            return Data()
        }
        return afterCompress
    }
}
