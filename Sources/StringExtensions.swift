//
//  StringExtensions.swift
//  ULima
//
//  Created by Gabriel Lanata on 2/4/15.
//  Copyright (c) 2015 is.oto.pe. All rights reserved.
//

import Foundation

public extension String {
    
    public var length: Int {
        return self.characters.count
    }
    
    public func stringByRemovingHTML() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    public func substring(range: Range<Int>) -> String {
        let startIndex = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.characters.index(startIndex, offsetBy: range.upperBound - range.lowerBound)
        return self.substring(with: startIndex..<endIndex)
    }
    
    public func substring(start: Int) -> String {
        return self.substring(range: start..<self.length)
    }
    
    public func substring(end: Int) -> String {
        return self.substring(range: 0..<end)
    }
    
    public func substring(start: Int, end: Int) -> String {
        return self.substring(range: start..<end)
    }
    
    public func substring(start: Index) -> String {
        return self.substring(with: start..<self.endIndex)
    }
    
    public func substring(end: Index) -> String {
        return self.substring(with: self.startIndex..<end)
    }
    
    public func substring(start: Index, end: Index) -> String {
        return self.substring(with: start..<end)
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
    
    public func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func clean(minSize: Int = 0) -> String? {
        let trimmed = trim()
        return (trimmed.length > minSize ? trimmed : nil)
    }
    
    public func urlEncode() -> String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    public mutating func uppercaseFirst() {
        guard length > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).uppercased())
    }
    
    public mutating func lowercaseFirst() {
        guard length > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
    }
    
    public func uppercasedFirst() -> String {
        guard length > 0 else { return self }
        let first = self.substring(end: 1)
        let rest = self.substring(start: 1)
        return first.uppercased()+rest
    }
    
    public func lowercasedFirst() -> String {
        guard length > 0 else { return self }
        let first = self.substring(end: 1)
        let rest = self.substring(start: 1)
        return first.lowercased()+rest
    }
    
    public func indexOf(_ target: String) -> Int? {
        let range = self.range(of: target)
        if let range = range {
            return self.characters.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    public func indexOf(_ target: String, startIndex: Int) -> Int? {
        let startRange = self.characters.index(self.startIndex, offsetBy: startIndex)
        let range = self.range(of: target, options: NSString.CompareOptions.literal, range: Range<String.Index>(startRange..<self.endIndex))
        if let range = range {
            return self.characters.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    public func lastIndexOf(_ target: String) -> Int? {
        var index: Int?
        var stepIndex = self.indexOf(target) ?? -1
        while stepIndex > -1 {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length) ?? -1
            } else {
                stepIndex = -1
            }
        }
        return index
    }
    
    public func addPaddingAfter(_ length: Int) -> String {
        let paddingCount = max(length-self.characters.count, 0)
        let paddingString = String(repeating: " ", count: paddingCount)
        return self+paddingString
    }
    
}


enum StringParsingError: Error {
    case failedToProcessBytes, failedToProcessData, failedToConvertToData
}

public extension String {
    
    init(bytes: [UInt8]) throws {
        guard let parsedString = String(bytes: bytes, encoding: .utf8) else {
            throw StringParsingError.failedToProcessBytes
        }
        self = parsedString
    }
    
    func bytes() throws -> [UInt8] {
        let data = try self.data()
        return [UInt8](data)
    }
    
    init(data: Data) throws {
        guard let parsedString = String(data: data, encoding: .utf8) else {
            throw StringParsingError.failedToProcessData
        }
        self = parsedString
    }
    
    func data() throws -> Data {
        guard let parsedData = self.data(using: .utf8) else {
            throw StringParsingError.failedToConvertToData
        }
        return parsedData
    }
    
}


#if os(iOS)
    public extension String {
        
        public func justifiedAttributed() -> NSAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.alignment = .justified
            return NSAttributedString(string: self, attributes: [NSParagraphStyleAttributeName : paragraphStyle, NSBaselineOffsetAttributeName : 0])
        }
        
    }
    
    public extension NSAttributedString {
        
        public convenience init(string: String, font: UIFont?, color: UIColor? = nil) {
            var attributes = [String : AnyObject]()
            if font  != nil { attributes[NSFontAttributeName] = font! }
            if color != nil { attributes[NSForegroundColorAttributeName] = color! }
            self.init(string: string, attributes: attributes)
        }
        
    }
    
    public extension NSMutableAttributedString {
        
        public func append(string: String, font: UIFont? = nil, color: UIColor? = nil) {
            self.append(NSAttributedString(string: string, font: font, color: color))
        }
        
    }
#endif

