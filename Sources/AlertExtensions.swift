//
//  AlertExtensions.swift
//  StartAppsKitExtensionsPackageDescription
//
//  Created by Gabriel Lanata on 12/10/17.
//
//  Credit to: https://github.com/hightower/UIAlertController-Show
//

#if os(iOS)
    
    import UIKit
    
    private var _AlertWindowAssociationKey: UInt8 = 0
    
    extension UIAlertController {
        
        private var alertWindow: UIWindow? {
            get {
                return objc_getAssociatedObject(self, &_AlertWindowAssociationKey) as? UIWindow
            }
            set {
                objc_setAssociatedObject(self, &_AlertWindowAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        
        public convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, cancelButtonTitle: String? = "OK") {
            self.init(title: title, message: message, preferredStyle: preferredStyle)
            self.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        }
        
        @discardableResult
        public func show(from fromVC: UIViewController? = nil, _ animated: Bool = true, completion: (() -> Void)? = nil) -> UIAlertController {
            if let fromVC = fromVC {
                fromVC.present(self, animated: animated, completion: completion)
            } else {
                alertWindow = UIWindow(frame: UIScreen.main.bounds)
                alertWindow?.rootViewController = UIViewController()
                alertWindow?.windowLevel = UIWindow.Level.alert + 1
                alertWindow?.makeKeyAndVisible()
                alertWindow?.rootViewController?.present(self, animated: animated, completion: completion)
            }
            return self
        }
        
        override open func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            self.alertWindow?.isHidden = true
            self.alertWindow = nil
        }
        
    }
    
#endif

