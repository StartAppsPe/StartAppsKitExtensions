//
//  OperatorExtensions.swift
//  StartAppsKit
//
//  Created by Gabriel Lanata on 14/10/16.
//
//

precedencegroup NilAssignablePrecedence {}

// If rhs not nil, set value. lhs is not replaced if rhs is nil.
infix operator ?= : NilAssignablePrecedence
public func ?=<T>(lhs: inout T, rhs: @autoclosure () -> T?) {
    if let nv = rhs() { lhs = nv }
}

// If lhs is nil, set value. rhs is not called if lhs is not nil.
infix operator |= : NilAssignablePrecedence
public func |=<T>(lhs: inout T?, rhs: @autoclosure () -> T?) {
    if lhs == nil { lhs = rhs() }
}
