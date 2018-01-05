//
//  StyleKit.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

public enum Attribute {
    case currentHintLabel, nextHintLabel
}

public enum Color {
    case baseGreenColor
}

class StyleKit {
    
    // swiftlint:disable cyclomatic_complexity
    
    static func attributedText(text: String, attribute: Attribute) -> NSAttributedString {
        var attributedDictionary = [String: AnyObject]()
        switch attribute {
        case .currentHintLabel:
            attributedDictionary =  attributedText(color: UIColor.white, font: UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight))
        case .nextHintLabel:
            attributedDictionary =  attributedText(color: UIColor.white, font: UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight))
        }
        return NSAttributedString(string: text, attributes: attributedDictionary)
    }
    
    static func colorType(color: Color) -> UIColor {
        switch color {
        case .baseGreenColor:
            return UIColor(hexString: "#6EC05D")!
        }
    }
    
    static func attributedText(color: UIColor, font: UIFont, alignment: NSTextAlignment = .left, underline: Bool = false) -> [String: AnyObject] {
        var attributedText = [String: AnyObject]()
        attributedText[NSForegroundColorAttributeName] = color
        attributedText[NSFontAttributeName] = font
        if underline {
            attributedText[NSUnderlineStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue as AnyObject
        }
    
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3.5
        paragraphStyle.alignment = alignment

        attributedText[NSParagraphStyleAttributeName] = paragraphStyle
        
        return attributedText
    }
}