//
//  TimerExtensions.swift
//  StartAppsKit
//
//  Created by Gabriel Lanata on 11/16/14.
//  Copyright (c) 2014 StartApps. All rights reserved.
//

import Foundation

extension Timer {
    
    /********************************************************************************************************/
    // MARK: Closure Methods
    /********************************************************************************************************/
    
    public typealias TimerCallback = (Timer) -> Void
    
    private class TimerCallbackHolder : NSObject {
        var callback: TimerCallback
        
        init(callback: @escaping TimerCallback) {
            self.callback = callback
        }
        
        @objc func tick(_ timer: Timer) {
            callback(timer)
        }
    }
    
    @discardableResult
    public convenience init(timeInterval interval: TimeInterval, repeats: Bool, actions: @escaping TimerCallback) {
        #if os(iOS) || os(macOS)
        if #available(iOS 10.0, OSX 10.12, *) {
            self.init(timeInterval: interval, repeats: repeats, block: actions)
        } else {
            let holder = TimerCallbackHolder(callback: actions)
            holder.callback = actions
            self.init(timeInterval: interval, target: holder, selector: #selector(TimerCallbackHolder.tick(_:)), userInfo: nil, repeats: repeats)
            }
        #else
            self.init(timeInterval: interval, repeats: repeats, block: actions)
        #endif
    }
    
    @discardableResult
    public class func scheduledTimer(timeInterval interval: TimeInterval, repeats: Bool, actions: @escaping TimerCallback) -> Timer {
        #if os(iOS) || os(macOS)
            if #available(iOS 10.0, OSX 10.12, *) {
                return self.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: actions)
            } else {
                let holder = TimerCallbackHolder(callback: actions)
                holder.callback = actions
                return self.scheduledTimer(timeInterval: interval, target: holder, selector: #selector(TimerCallbackHolder.tick(_:)), userInfo: nil, repeats: repeats)
            }
        #else
            return self.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: actions)
        #endif
    }
    
}
