//
//  AttributedStringExtension.swift
//  Mall
//
//  Created by midland on 2019/7/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

public extension NSMutableAttributedString {
    /// 获取范围
    func bf_allRange() -> NSRange {
        return NSMakeRange(0,length)
    }
    
    /// 添加中划线
    @discardableResult
    func bf_addMidline(_ lineHeght: Int) -> NSMutableAttributedString {
        addAttributes([.strikethroughStyle:lineHeght], range: bf_allRange())
        return self
    }
    
    /// 中划线颜色
    @discardableResult
    func bf_midlineColor(_ color: UIColor) -> NSMutableAttributedString{
        addAttributes([.strikethroughColor:color], range: bf_allRange())
        return self
    }
    
    /// 给文字添加描边
    ///
    /// - Parameter width: 描边宽带
    /// - Returns:
    @discardableResult
    func bf_addStroke(_ width: CGFloat) -> NSMutableAttributedString {
        addAttributes([.strokeWidth:width], range: bf_allRange())
        return self
    }
    
    /// 描边颜色
    @discardableResult
    func bf_strokeColor(_ color: UIColor) -> NSMutableAttributedString {
        addAttributes([.strokeColor:color], range: bf_allRange())
        return self
    }
    
    /// 添加字间距
    @discardableResult
    func bf_addSpace(_ space: CGFloat) -> NSMutableAttributedString {
        addAttributes([.kern:space], range: bf_allRange())
        return self
    }
    
    /// 背景色
    @discardableResult
    func bf_backgroundColor(_ color: UIColor) -> NSMutableAttributedString {
        addAttributes([.backgroundColor:color], range: bf_allRange())
        return self
    }
    
    /// 文字颜色
    @discardableResult
    func bf_color(_ color: UIColor) -> NSMutableAttributedString {
        addAttributes([.foregroundColor:color], range: bf_allRange())
        return self
    }
    
    /// 添加下划线
    @discardableResult
    func bf_addUnderLine(_ style: NSUnderlineStyle) -> NSMutableAttributedString{
        addAttributes([.underlineStyle:style.rawValue], range: bf_allRange())
        return self
    }
    
    /// 下划线颜色
    @discardableResult
    func bf_underLineColor(_ color: UIColor) -> NSMutableAttributedString{
        addAttributes([.underlineColor:color], range: bf_allRange())
        return self
    }
    
    /// 字体
    @discardableResult
    func bf_font(_ font: UIFont) -> NSMutableAttributedString{
        addAttributes([.font:font], range: bf_allRange())
        return self
    }
    
    /// 系统字体大小
    @discardableResult
    func bf_fontSize(_ size: CGFloat)->NSMutableAttributedString{
        addAttributes([.font:UIFont.systemFont(ofSize: size)], range: bf_allRange())
        return self
    }
    
    /// 添加行间距
    @discardableResult
    func bf_addLineSpace(_ space: CGFloat) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = space
        style.lineBreakMode = .byCharWrapping
        addAttribute(.paragraphStyle, value: style, range: bf_allRange())
        return self
    }
    /// 拼接富文本
    @discardableResult
    func bf_addAttribute(_ attribute: NSMutableAttributedString) -> NSMutableAttributedString {
        append(attribute)
        return self
    }
    
    /// 添加阴影
    @discardableResult
    func bf_addShadow(_ shadowOffset:CGSize? = nil ,_ color: UIColor? = nil) -> NSMutableAttributedString {
        let shadow = NSShadow.init()
        shadow.shadowColor = color == nil ? UIColor.black : color!
        shadow.shadowOffset = shadowOffset == nil ? CGSize.init(width: 2, height: 2) : shadowOffset!
        addAttributes([NSAttributedString.Key.shadow: shadow], range: bf_allRange())
        return self
    }
}


public extension String {
    /// 字符串转富文本
    func bf_toAttribute() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}
