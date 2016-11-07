//
//  RawRepresentableExtensions.swift
//  StartAppsKitExtensions
//
//  Created by Gabriel Lanata on 7/11/16.
//
//

enum RawRepresentableInitError: Error {
    case invalidValue(Any)
}

extension RawRepresentable {
    
    init(rawValue: RawValue) throws {
        guard let value = Self(rawValue: rawValue) else {
            throw RawRepresentableInitError.invalidValue(rawValue)
        }
        self = value
    }
    
}
