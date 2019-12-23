//
//  SA.swift
//  Aprils
//
//  Created by Gabriel Lanata on 12/5/14.
//  Copyright (c) 2014 StartApps. All rights reserved.
//

#if os(iOS)
    
    import UIKit
    
    extension UIView {
        
        @IBInspectable public var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                if newValue == -1 {
                    layer.cornerRadius = self.bounds.size.width/2
                } else {
                    layer.cornerRadius = newValue
                }
                updateLayerEffects()
            }
        }
        
        @IBInspectable public var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {
                layer.shadowRadius  = newValue;
                updateLayerEffects()
            }
        }
        
        @IBInspectable public var shadowOpacity: Float {
            get {
                return layer.shadowOpacity
            }
            set {
                layer.shadowOpacity = newValue
                updateLayerEffects()
            }
        }
        
        @IBInspectable public var shadowColor: UIColor? {
            get {
                guard let cgShadowColor = layer.shadowColor else { return nil }
                return UIColor(cgColor: cgShadowColor)
            }
            set {
                layer.shadowColor = newValue?.cgColor
                updateLayerEffects()
            }
        }
        
        @IBInspectable public var shadowOffset: CGSize {
            get {
                return layer.shadowOffset
            }
            set {
                layer.shadowOffset = newValue
                updateLayerEffects()
            }
        }
        
        @IBInspectable public var rotation: CGFloat {
            get {
                let radians = atan2(transform.b, transform.d)
                return radians * (180.0 / CGFloat(Double.pi))
            }
            set {
                let radians = newValue * (CGFloat(Double.pi) / 180.0)
                transform = CGAffineTransform(rotationAngle: radians)
            }
        }
        
        @IBInspectable public var borderColor: UIColor? {
            get {
                return (layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil)
            }
            set {
                layer.borderColor = newValue?.cgColor
                updateLayerEffects()
            }
        }
        
        @IBInspectable public var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
                updateLayerEffects()
            }
        }
        
        public func updateLayerEffects() {
            if shadowOpacity != 0 {
                layer.masksToBounds = false
            } else if cornerRadius != 0 {
                layer.masksToBounds = true
            }
        }
        
    }
    
    extension UIButton {
        
        @IBInspectable public override var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                if newValue == -1 {
                    layer.cornerRadius = self.bounds.size.width/2
                } else {
                    layer.cornerRadius = newValue
                }
                updateLayerEffects()
            }
        }
        
        @IBInspectable public override var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {
                layer.shadowRadius  = newValue;
                updateLayerEffects()
            }
        }
        
        @IBInspectable public override var shadowOpacity: Float {
            get {
                return layer.shadowOpacity
            }
            set {
                layer.shadowOpacity = newValue
                updateLayerEffects()
            }
        }
        
        
        @IBInspectable public override var shadowColor: UIColor? {
            get {
                guard let cgShadowColor = layer.shadowColor else { return nil }
                return UIColor(cgColor: cgShadowColor)
            }
            set {
                layer.shadowColor = newValue?.cgColor
                updateLayerEffects()
            }
        }
        
        @IBInspectable public override var rotation: CGFloat {
            get {
                let radians = atan2(transform.b, transform.d)
                return radians * (180.0 / CGFloat(Double.pi))
            }
            set {
                let radians = newValue * (CGFloat(Double.pi) / 180.0)
                transform = CGAffineTransform(rotationAngle: radians)
            }
        }
        
        @IBInspectable public override var borderColor: UIColor? {
            get {
                return (layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil)
            }
            set {
                layer.borderColor = newValue?.cgColor
                updateLayerEffects()
            }
        }
        
        @IBInspectable public override var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
                updateLayerEffects()
            }
        }
        
        //        public func updateLayerEffects() {
        //            if shadowOpacity != 0 {
        //                layer.shadowOffset  = CGSize(width: 0, height: 0);
        //                layer.masksToBounds = false
        //            } else if cornerRadius != 0 {
        //                layer.masksToBounds = true
        //            }
        //        }
        
    }
    
    extension UIView {
        
        @discardableResult
        public func addParallax(amount: Int) -> UIMotionEffect {
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                                   type: .tiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = -amount
            verticalMotionEffect.maximumRelativeValue = amount
            
            // Set horizontal effect
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                                     type: .tiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = -amount
            horizontalMotionEffect.maximumRelativeValue = amount
            
            // Create group to combine both
            let group = UIMotionEffectGroup()
            group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
            
            // Add both effects to your view
            self.addMotionEffect(group)
            return group
        }
        
        @discardableResult
        public func addParallax(keyPath: String, type: UIInterpolatingMotionEffect.EffectType, amount: Int) -> UIInterpolatingMotionEffect {
            let motionEffect = UIInterpolatingMotionEffect(keyPath: keyPath, type: type)
            motionEffect.minimumRelativeValue = -amount
            motionEffect.maximumRelativeValue = amount
            self.addMotionEffect(motionEffect)
            return motionEffect
        }
        
    }
    
    extension UIView {
        
        public func fillWithSubview(_ view: UIView, margin: CGFloat = 0.0) {
            
            // Add view
            view.translatesAutoresizingMaskIntoConstraints = false
            var newFrame = view.frame
            newFrame.size.width = self.bounds.width
            view.layoutIfNeeded()
            view.updateConstraintsIfNeeded()
            view.frame = newFrame
            self.addSubview(view)
            
            // Add constraints
            self.addConstraint(
                NSLayoutConstraint(item: view,
                                   attribute: .top, relatedBy: .equal,
                                   toItem: self, attribute: .top,
                                   multiplier: 1.0, constant: margin
                )
            )
            self.addConstraint(
                NSLayoutConstraint(item: view,
                                   attribute: .leading, relatedBy: .equal,
                                   toItem: self, attribute: .leading,
                                   multiplier: 1.0, constant: margin
                )
            )
            self.addConstraint(
                NSLayoutConstraint(item: self,
                                   attribute: .bottom, relatedBy: .equal,
                                   toItem: view, attribute: .bottom,
                                   multiplier: 1.0, constant: margin
                )
            )
            self.addConstraint(
                NSLayoutConstraint(item: self,
                                   attribute: .trailing, relatedBy: .equal,
                                   toItem: view, attribute: .trailing,
                                   multiplier: 1.0, constant: margin
                )
            )
            
        }
        
    }
    
    extension UIViewController {
        
        public func insertChild(viewController: UIViewController, inView: UIView) {
            addChild(viewController)
            viewController.willMove(toParent: self)
            inView.fillWithSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
        
        public func removeChild(viewController: UIViewController) {
            viewController.removeFromParent()
            viewController.willMove(toParent: nil)
            viewController.view?.removeFromSuperview()
            viewController.didMove(toParent: nil)
        }
        
    }
    
    private var _viewBlurView: UInt8 = 212
    
    extension UIView {
        
        public private(set) var blurView: UIVisualEffectView? {
            get { return objc_getAssociatedObject(self, &_viewBlurView) as? UIVisualEffectView }
            set { objc_setAssociatedObject(self, &_viewBlurView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        }
        
        public func addBlur(style: UIBlurEffect.Style = .light, animated: Bool) {
            guard blurView == nil else { return }
            guard !UIAccessibility.isReduceTransparencyEnabled else { return }
            blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            fillWithSubview(blurView!)
            if animated {
                blurView?.alpha = 0.0
                UIView.animate(withDuration: 0.4, animations: {
                    self.blurView?.alpha = 1.0
                })
            }
        }
        
        public func removeBlur(animated: Bool) {
            guard blurView != nil else { return }
            if animated {
                UIView.animate(withDuration: 0.4, animations: {
                    self.blurView?.alpha = 0.0
                }, completion: { _ in
                    self.blurView?.removeFromSuperview()
                    self.blurView = nil
                })
            }
        }
        
    }
    
#endif

