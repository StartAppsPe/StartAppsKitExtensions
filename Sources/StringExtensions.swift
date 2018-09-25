//
//  StringExtensions.swift
//  ULima
//
//  Created by Gabriel Lanata on 2/4/15.
//  Copyright (c) 2015 is.oto.pe. All rights reserved.
//

import Foundation

public extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public var length: Int {
        return self.count
    }
    
    public func substring(range: Range<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: range.upperBound - range.lowerBound)
        return String(self[startIndex..<endIndex])
    }
    
    public func substring(start: Int) -> String {
        return substring(start: start, end: self.count)
    }
    
    public func substring(end: Int) -> String {
        return substring(start: 0, end: end)
    }
    
    public func substring(start: Int, end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }
    
    public func substring(start: Index) -> String {
        return String(self[start..<self.endIndex])
    }
    
    public func substring(end: Index) -> String {
        return String(self[startIndex..<end])
    }
    
    public func substring(start: Index, end: Index) -> String {
        return String(self[start..<end])
    }
    
    public func substring(start: String, end: String) -> String? {
        if let startRange = range(of: start) {
            let newString = self.substring(start: startRange.upperBound)
            if let endRange = newString.range(of: end) {
                return newString.substring(end: endRange.lowerBound)
            }
        }
        return nil
    }
    
    public func substring(start: String) -> String? {
        if let startRange = range(of: start) {
            return substring(start: startRange.upperBound)
        }
        return nil
    }
    
    public func substring(end: String) -> String? {
        if let endRange = range(of: end) {
            return substring(end: endRange.lowerBound)
        }
        return nil
    }
    
    public func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

    }
    
//    public func trimmed() -> String {
//        return self.trimmed
//    }
    
    
    @available(*, deprecated: 2.0, message: "Use cleaned() instead", renamed: "clean(minSize:)")
    public func clean(minSize: Int = 1) -> String? {
        let trimmedSelf = trimmed()
        return (trimmedSelf.count >= minSize ? trimmedSelf : nil)
    }
    
    public func cleaned(minSize: Int = 1) -> String? {
        let trimmedSelf = trimmed()
        return (trimmedSelf.count >= minSize ? trimmedSelf : nil)
    }
    
    public mutating func capitalizeFirst() {
        self.uppercaseFirst()
    }
    
    public mutating func uppercaseFirst() {
        guard self.count > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).uppercased())
    }
    
    public mutating func lowercaseFirst() {
        guard self.count > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
    }
    
    public var capitalizedFirst: String {
        return self.uppercasedFirst()
    }
    
    public func uppercasedFirst() -> String {
        guard self.count > 0 else { return self }
        let first = self.substring(end: 1)
        let rest = self.substring(start: 1)
        return first.uppercased()+rest
    }
    
    public func lowercasedFirst() -> String {
        guard self.count > 0 else { return self }
        let first = self.substring(end: 1)
        let rest = self.substring(start: 1)
        return first.lowercased()+rest
    }
    
    public func indexOf(_ target: String) -> Int? {
        let range = self.range(of: target)
        if let range = range {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    public func indexOf(_ target: String, startIndex: Int) -> Int? {
        let startRange = self.index(self.startIndex, offsetBy: startIndex)
        let range = self.range(of: target, options: NSString.CompareOptions.literal, range: startRange..<self.endIndex)
        if let range = range {
            return self.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    public func lastIndexOf(_ target: String) -> Int? {
        var index: Int?
        var stepIndex = self.indexOf(target) ?? -1
        while stepIndex > -1 {
            index = stepIndex
            if stepIndex + target.count < self.count {
                stepIndex = indexOf(target, startIndex: stepIndex + target.count) ?? -1
            } else {
                stepIndex = -1
            }
        }
        return index
    }
    
    public func addPaddingAfter(_ length: Int) -> String {
        let paddingCount = max(length-self.count, 0)
        let paddingString = String(repeating: " ", count: paddingCount)
        return self+paddingString
    }
    
}

public extension String {
    
    public func urlEncode() -> String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    public func jsonEncode() -> String {
        var encoded = self
        encoded = encoded.replacingOccurrences(of: "\\", with: "\\\\")
        encoded = encoded.replacingOccurrences(of: "\"", with: "\\\"")
        return encoded
    }
    
    public func xmlEncode() -> String {
        var encoded = self
        encoded = encoded.replacingOccurrences(of: "&", with: "&amp;")
        encoded = encoded.replacingOccurrences(of: "\"", with: "&quot;")
        encoded = encoded.replacingOccurrences(of: "'", with: "&#39;")
        encoded = encoded.replacingOccurrences(of: ">", with: "&gt;")
        encoded = encoded.replacingOccurrences(of: "<", with: "&lt;")
        return encoded
    }
    
    public func htmlEncode() -> String {
        var encoded = self
        encoded = encoded.replacingOccurrences(of: "&", with: "&amp;")
        encoded = encoded.replacingOccurrences(of: "\"", with: "&quot;")
        encoded = encoded.replacingOccurrences(of: "'", with: "&#39;")
        encoded = encoded.replacingOccurrences(of: ">", with: "&gt;")
        encoded = encoded.replacingOccurrences(of: "<", with: "&lt;")
        return encoded
    }
    
    public func removingHTML() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    // Legacy support
    public func stringByRemovingHTML() -> String {
        return self.removingHTML()
    }
    
}


public enum StringParsingError: Error {
    case failedToProcessBytes, failedToProcessData, failedToConvertToData
}

public extension String {
    
    public init(bytes: [UInt8]) throws {
        guard let parsedString = String(bytes: bytes, encoding: .utf8) else {
            throw StringParsingError.failedToProcessBytes
        }
        self = parsedString
    }
    
    public func bytes() throws -> [UInt8] {
        let data = try self.data()
        return [UInt8](data)
    }
    
    public init(data: Data) throws {
        guard let parsedString = String(data: data, encoding: .utf8) else {
            throw StringParsingError.failedToProcessData
        }
        self = parsedString
    }
    
    public func data() throws -> Data {
        guard let parsedData = self.data(using: .utf8) else {
            throw StringParsingError.failedToConvertToData
        }
        return parsedData
    }
    
}

// Mark: Insensitive operators

extension String {
    
    public var insensitive: String {
        return self.folding(options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive], locale: nil)
    }
    
}

public func ~= (lhs: String, rhs: String) -> Bool {
    return lhs.insensitive == rhs.insensitive
}

infix operator ~<
public func ~< (lhs: String, rhs: String) -> Bool {
    return lhs.insensitive < rhs.insensitive
}

infix operator ~<=
public func ~<= (lhs: String, rhs: String) -> Bool {
    return lhs.insensitive <= rhs.insensitive
}

infix operator ~>
public func ~> (lhs: String, rhs: String) -> Bool {
    return lhs.insensitive > rhs.insensitive
}

infix operator ~>=
public func ~>= (lhs: String, rhs: String) -> Bool {
    return lhs.insensitive >= rhs.insensitive
}

#if os(iOS)

import UIKit

public extension String {
    
    public func justifiedAttributed() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .justified
        return NSAttributedString(
            string: self,
            attributes: [
                NSAttributedStringKey.paragraphStyle: paragraphStyle,
                NSAttributedStringKey.baselineOffset: 0
            ]
        )
    }
    
    var htmlAttributedString: NSAttributedString {
        let stringData = data(using: .isoLatin1) ?? data(using: .unicode) ?? data(using: .utf8)!
        return try! NSAttributedString(
            data: stringData,
            options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html
            ],
            documentAttributes: nil
        )
    }
    
}

public extension NSAttributedString {
    
    public convenience init(string: String, font: UIFont?, color: UIColor? = nil) {
        var attributes = [NSAttributedStringKey : Any]()
        if font  != nil { attributes[NSAttributedStringKey.font] = font! }
        if color != nil { attributes[NSAttributedStringKey.foregroundColor] = color! }
        self.init(string: string, attributes: attributes)
    }
    
}

public extension NSMutableAttributedString {
    
    public func append(string: String, font: UIFont? = nil, color: UIColor? = nil) {
        self.append(NSAttributedString(string: string, font: font, color: color))
    }
    
}

#endif
