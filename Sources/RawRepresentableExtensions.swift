//
//  RawRepresentableExtensions.swift
//  StartAppsKitExtensions
//
//  Created by Gabriel Lanata on 7/11/16.
//
//

public enum RawRepresentableInitError: Error {
    case invalidValue(Any)
}

extension RawRepresentable {
    
    public init(rawValue: RawValue) throws {
        guard let value = Self(rawValue: rawValue) else {
            throw RawRepresentableInitError.invalidValue(rawValue)
        }
        self = value
    }
    
}
