//
//  DeviceExtensions.swift
//  StartAppsKit
//
//  Created by Gabriel Lanata on 8/27/15.
//  Copyright (c) 2015 StartAppsKit. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIDevice {
    
    public var platform: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    public var platformString: String {
        let platform = self.platform
        switch platform {
        case "iPhone1,1": return "iPhone 1G"
        case "iPhone1,2": return "iPhone 3G"
        case "iPhone2,1": return "iPhone 3GS"
        case "iPhone3,1": return "iPhone 4"
        case "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4S"
        case "iPhone5,1": return "iPhone 5"
        case "iPhone5,2": return "iPhone 5"
        case "iPhone5,3": return "iPhone 5C"
        case "iPhone6,1": return "iPhone 5S"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone8,1": return "iPhone 6S"
        case "iPhone8,2": return "iPhone 6S Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1": return "iPhone 7"
        case "iPhone9,3": return "iPhone 7"
        case "iPhone9,2": return "iPhone 7 Plus"
        case "iPhone9,4": return "iPhone 7 Plus"
        case "iPod1,1":   return "iPod Touch 1G"
        case "iPod2,1":   return "iPod Touch 2G"
        case "iPod3,1":   return "iPod Touch 3G"
        case "iPod4,1":   return "iPod Touch 4G"
        case "iPod5,1":   return "iPod Touch 5G"
        case "iPod7,1":   return "iPod Touch 6G"
        case "iPad1,1":   return "iPad"
        case "iPad2,1":   return "iPad 2"      // (WiFi)
        case "iPad2,2":   return "iPad 2"      // (GSM)
        case "iPad2,3":   return "iPad 2"      // (CDMA)
        case "iPad2,4":   return "iPad 2"      // (CDMA)
        case "iPad2,5":   return "iPad Mini"   // (WiFi)
        case "iPad2,6":   return "iPad Mini"
        case "iPad2,7":   return "iPad Mini"   // (GSM+CDMA)
        case "iPad3,1":   return "iPad 3"      // (WiFi)
        case "iPad3,2":   return "iPad 3"      // (GSM+CDMA)
        case "iPad3,3":   return "iPad 3"
        case "iPad3,4":   return "iPad 4"      // (WiFi)
        case "iPad3,5":   return "iPad 4"
        case "iPad3,6":   return "iPad 4"      // (GSM+CDMA)
        case "iPad4,1":   return "iPad Air"    // (WiFi)
        case "iPad4,2":   return "iPad Air"    // (Cellular)
        case "iPad4,4":   return "iPad Mini 2" // (WiFi)
        case "iPad4,5":   return "iPad Mini 2" // (Cellular)
        case "iPad4,6":   return "iPad Mini 2"
        case "iPad4,7":   return "iPad Mini 3"
        case "iPad4,8":   return "iPad Mini 3"
        case "iPad4,9":   return "iPad Mini 3"
        case "iPad5,1":   return "iPad Mini 4"
        case "iPad5,2":   return "iPad Mini 4"
        case "iPad5,3":   return "iPad Air 2"
        case "iPad5,4":   return "iPad Air 2"
        case "iPad6,7":   return "iPad Pro (12.9 inch)"
        case "iPad6,8":   return "iPad Pro (12.9 inch)"
        case "iPad6,3":   return "iPad Pro (9.7 inch)"
        case "iPad6,3":   return "iPad Pro (9.7 inch)"
        case "Watch1,1":   return "Apple Watch"
        case "Watch1,2":   return "Apple Watch"
        case "Watch2,6":   return "Apple Watch Series 1"
        case "Watch2,7":   return "Apple Watch Series 1"
        case "Watch2,3":   return "Apple Watch Series 2"
        case "Watch2,4":   return "Apple Watch Series 2"
        case "AppleTV2,1":   return "Apple TV 2G"
        case "AppleTV3,1":   return "Apple TV 3G"
        case "AppleTV3,2":   return "Apple TV 3G"
        case "AppleTV5,3":   return "Apple TV 4G"
        case "i386":      return "Simulator"
        case "x86_64":    return "Simulator"
        default:          return platform
        }
    }
    
}

#endif
