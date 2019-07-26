//
//  BFNameSpace.swift
//  Mall
//
//  Created by midland on 2019/7/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 添加bf为命名空间
// 定义泛型类
public final class BFKit<BFBase> {
    public let base: BFBase
    public init(_ base: BFBase) {
        self.base = base
    }
}

// 定义泛型协议
public protocol BFKitCompatible {
    associatedtype CompatibleType
    var bf: CompatibleType { get }
}

// 协议的扩展
public  extension BFKitCompatible {
    public var bf: BFKit<Self> {
        return BFKit(self)
    }
}

// 实现命名空间bf
// 需要注释 Tiercel extension UIView: TiercelCompatible {}
extension UIView: BFKitCompatible {}

extension BFKit where BFBase: UIImageView {
    
    /// Kingfisher图片加载
    ///
    /// - Parameters:
    ///   - imageUrl:  将要加载的图片
    ///   - placeholder: 占位图片
    ///   - isShowIndicator: 是否展示指示器
    ///   - options: forceRefresh 强制刷新 每次联网刷新 transition 1s渐显效果
    func setImage(imageUrl: String?, placeholder: String? = "appDefault", isShowIndicator: Bool? = true, isNeedForceRefresh: Bool = false) {
        base.kf.indicatorType = isShowIndicator! ? .activity : .none
        var image: UIImage?
        if let placeholder = placeholder {
            image = UIImage.init(named: placeholder)
        }
        var options = [KingfisherOptionsInfoItem]()
        if isNeedForceRefresh {
            options.append(.forceRefresh)
        }
        options += [.transition(ImageTransition.fade(1))]
        base.kf.setImage(with: URL.init(string: imageUrl ?? ""), placeholder: image, options:options, progressBlock: { (_, _) in
            
        }) { (image, error, cacheType, url) in
            
        }
    }
    
}

extension BFKit where BFBase: UIButton {
    
    /// set button background image
    ///
    /// - Parameters:
    ///   - url: remote image url
    ///   - placeholder: default image
    ///   - state: button state
    func setButtonBGImage(url: URL?, placeholder: String? = "appDefault", state: UIControl.State) {
        
        var image: UIImage?
        if let placeholder = placeholder {
            image = UIImage.init(named: placeholder)
        }
        var options = [KingfisherOptionsInfoItem]()
        options += [.transition(ImageTransition.fade(1))]
        base.kf.setBackgroundImage(with: url, for: state, placeholder: image, options: options, progressBlock: { (_, _) in
            
        }) { (_, _, _, _) in
        }
    }
    
    // 设置按钮的Image
    func setButtonImage(url: URL?, placeholder: String? = "icon-60", state: UIControl.State) {
        
        var image: UIImage?
        if let placeholder = placeholder {
            image = UIImage.init(named: placeholder)
        }
        var options = [KingfisherOptionsInfoItem]()
        options += [.transition(ImageTransition.fade(1))]
        base.kf.setImage(with: url, for: state, placeholder: image, options: options, progressBlock: { (_, _) in
            
        }) { (_, _, _, _) in
            
        }
    }
}

// MARK: - UIView拓展
extension BFKit where BFBase: UIView {
    
    /// x
    var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.x    = newValue
            base.frame            = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.y    = newValue
            base.frame            = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return base.frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.height = newValue
            base.frame            = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return base.frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.width = newValue
            base.frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return base.frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size = newValue
            base.frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return base.center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter.x = newValue
            base.center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return base.center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter.y = newValue
            base.center = tempCenter
        }
    }
    
    var right: CGFloat {
        get {
            return self.x + self.width
        }
        set {
            var r = base.frame
            r.origin.x = newValue - base.frame.size.width
            base.frame = r
        }
    }
}
