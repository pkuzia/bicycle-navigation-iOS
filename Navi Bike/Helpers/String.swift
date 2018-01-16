//
//  String.swift
//  Navi Bike
//
//  Created by Przemysław Kuzia on 12/28/17
//  Copyright (c) 2017 pkuzia. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    func convertHtml() -> String {
        guard let data = data(using: .utf8) else { return self }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil).string.replacingOccurrences(of: "\n", with: " ")
        } catch {
            return self
        }
    }
}
