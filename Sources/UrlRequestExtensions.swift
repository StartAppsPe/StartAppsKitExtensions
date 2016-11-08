//
//  UrlRequestExtensions.swift
//  StartAppsKitExtensions
//
//  Created by Gabriel Lanata on 7/11/16.
//
//

import Foundation

public extension URLRequest {
    
    public mutating func setHttpBody(_ body: Data) throws {
        let data = body
        self.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        self.httpMethod = "POST"
        self.httpBody = data
    }
    
    public mutating func setHttpBody(_ body: String) throws {
        let data = body.data(using: .utf8)!
        self.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        self.httpMethod = "POST"
        self.httpBody = data
    }
    
    #if os(iOS)
    
    public mutating func setHttpBody(_ body: UIImage) throws {
        let data = UIImagePNGRepresentation(body)
        self.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        self.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        self.httpMethod = "POST"
        self.httpBody = data
    }
    
    #endif
    
}
