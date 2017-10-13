//
//  OptionalExtensions.swift
//  StartAppsKitExtensionsPackageDescription
//
//  Created by Gabriel Lanata on 12/10/17.
//

import Foundation

enum OptionalError: LocalizedError {
    case unwrappingNone(String?)
    var errorDescription: String? {
        switch self {
        case .unwrappingNone(let errorMessage):
            return errorMessage ?? "Optional value does not exist".localized
        }
    }
}

extension Optional {
    
    func tryUnwrap(errorMessage: String? = nil) throws -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            throw OptionalError.unwrappingNone(errorMessage)
        }
    }
    
}

postfix operator †
public postfix func †<T>(_ a: T?) throws -> T {
    return try a.tryUnwrap()
}
