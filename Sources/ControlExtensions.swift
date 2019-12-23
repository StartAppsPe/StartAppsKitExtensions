//
//  ControlExtensions.swift
//  StartAppsKitExtensionsPackageDescription
//
//  Created by Gabriel Lanata on 16/10/17.
//

#if os(iOS)
    
    import UIKit
    
    extension UIActivityIndicatorView {
        
        public var active: Bool {
            get {
                return isAnimating
            }
            set {
                if newValue {
                    startAnimating()
                } else {
                    stopAnimating()
                }
            }
        }
        
    }
    
    extension UIRefreshControl {
        
        public var active: Bool {
            get {
                return isRefreshing
            }
            set {
                if newValue {
                    beginRefreshing()
                } else {
                    endRefreshing()
                }
            }
        }
        
    }
    
#endif

