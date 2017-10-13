//
//  OptionalExtensions.swift
//  StartAppsKitExtensionsPackageDescription
//
//  Created by Gabriel Lanata on 12/10/17.
//

import Foundation

public enum OptionalError: LocalizedError {
    case unwrappingNone(String?)
    public var errorDescription: String? {
        switch self {
        case .unwrappingNone(let errorMessage):
            return errorMessage ?? "Optional value does not exist".localized
        }
    }
}

public extension Optional {
    
    public func tryUnwrap(errorMessage: String? = nil) throws -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            throw OptionalError.unwrappingNone(errorMessage)
        }
    }
    
}

public postfix operator †
public postfix func †<T>(_ a: T?) throws -> T {
    return try a.tryUnwrap()
}
