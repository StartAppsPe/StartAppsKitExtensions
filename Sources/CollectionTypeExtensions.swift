//
//  ArrayExtensions.swift
//  StartApps
//
//  Created by Gabriel Lanata on 7/14/15.
//  Copyright (c) 2015 StartApps. All rights reserved.
//

import Foundation

public extension Collection {
    
    public func performEach(_ action: (Self.Iterator.Element) -> Void) {
        for element in self { action(element) }
    }
    
    
    public func find(_ isElement: (Self.Iterator.Element) -> Bool) -> Self.Iterator.Element? {
        if let index = index(where: isElement) {
            return self[index]
        }
        return nil
    }
    
    
    public func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.riffle()
        return list
    }
    
}

public extension Collection where Index == Int  {
    
    public var randomElement: Self.Iterator.Element? {
        return self[Random.new(max: Int(Int64(count))-1)]
    }
    
    public func contains(index: Int) -> Bool {
        guard index >= 0 else { return false }
        guard index < Int(Int64(count)) else { return false }
        return true
    }
    
}

public extension MutableCollection where Index == Int  {
    
    public mutating func riffle() {
        guard count > 1 else { return }
        for index in startIndex..<endIndex - 1 {
            let randomIndex = Int(arc4random_uniform(UInt32(endIndex - index))) + index
            if index != randomIndex { self.swapAt(index, randomIndex) }
        }
    }
    
}

public extension Collection where Iterator.Element : Equatable {
    
    public func uniqued() -> [Self.Iterator.Element] {
        var distinctElements: [Self.Iterator.Element] = []
        for element in self {
            if !distinctElements.contains(element) {
                distinctElements.append(element)
            }
        }
        return distinctElements
    }
    
    public func uniqued<T: Equatable>(_ by: @autoclosure (_ element: Self.Iterator.Element) -> T) -> [Self.Iterator.Element] {
        var distinctElements: [Self.Iterator.Element] = []
        for element in self {
            if distinctElements.find({ by($0) == by(element) }) == nil {
                distinctElements.append(element)
            }
        }
        return distinctElements
    }
    
}

public extension Set {
    
    public mutating func toggle(_ element: Element) -> Bool {
        if contains(element) {
            remove(element)
            return false
        } else {
            insert(element)
            return true
        }
    }
    
}


public extension Array {
    
    public mutating func popFirst() -> Element? {
        if let first = first {
            remove(at: 0)
            return first
        }
        return nil
    }
    
}

public extension RangeReplaceableCollection where Iterator.Element: Equatable {
    
    public mutating func appendUnique(_ element: Self.Iterator.Element) {
        if !contains(element) {
            append(element)
        }
    }
    
    public mutating func appendIfExists(_ element: Self.Iterator.Element?) {
        if let element = element {
            append(element)
        }
    }
    
    public mutating func appendUniqueIfExists(_ element: Self.Iterator.Element?) {
        if let element = element , !contains(element) {
            append(element)
        }
    }
    
    @discardableResult
    public mutating func remove(_ element: Self.Iterator.Element) -> Bool {
        if let index = index(of: element) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
    @discardableResult
    public mutating func toggle(_ element: Self.Iterator.Element) -> Bool {
        if let index = index(of: element) {
            self.remove(at: index)
            return false
        } else {
            self.append(element)
            return true
        }
    }
    
}

//public extension Range where  Iterator.Element : Comparable {
//    
//    public func contains(element: Element) -> Bool {
//        return self ~= element
//    }
//    
//    public func contains(range: Range) -> Bool {
//        return self ~= range
//    }
//    
//}


//public func ~=<I : Comparable>(pattern: Range<I>, value: Range<I>) -> Bool where I : Comparable {
//    return pattern ~= value.lowerBound || pattern ~= value.upperBound || value ~= pattern.lowerBound || value ~= pattern.upperBound
//}

