//
//  SA.swift
//  Aprils
//
//  Created by Gabriel Lanata on 12/5/14.
//  Copyright (c) 2014 StartApps. All rights reserved.
//

#if os(iOS)
    
    import UIKit
    
    public extension UIActivityIndicatorView {
        
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
    
    public extension UIRefreshControl {
        
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
    
    public extension UITableView {
        
        public func updateHeaderViewFrame() {
            guard let headerView = self.tableHeaderView else { return }
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let fitSize = CGSize(width: self.frame.size.width, height: 3000)
            let height = headerView.systemLayoutSizeFitting(fitSize,
                                                            withHorizontalFittingPriority: .required,
                                                            verticalFittingPriority: .defaultLow).height
            var headerViewFrame = headerView.frame
            headerViewFrame.size.height = height
            headerView.frame = headerViewFrame
            self.tableHeaderView = headerView
        }
        
        public func updateFooterViewFrame() {
            guard let footerView = self.tableFooterView else { return }
            footerView.setNeedsLayout()
            footerView.layoutIfNeeded()
            
            let fitSize = CGSize(width: self.frame.size.width, height: 3000)
            let height = footerView.systemLayoutSizeFitting(fitSize,
                                                            withHorizontalFittingPriority: .required,
                                                            verticalFittingPriority: .defaultLow).height
            var footerViewFrame = footerView.frame
            footerViewFrame.size.height = height
            footerView.frame = footerViewFrame
            self.tableFooterView = footerView
        }
        
    }

    
//    public extension UIView {
//        
//        @IBInspectable public var cornerRadius: CGFloat {
//            get {
//                return layer.cornerRadius
//            }
//            set {
//                if newValue == -1 {
//                    layer.cornerRadius = self.bounds.size.width/2
//                } else {
//                    layer.cornerRadius = newValue
//                }
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public var shadowRadius: CGFloat {
//            get {
//                return layer.shadowRadius
//            }
//            set {
//                layer.shadowRadius  = newValue;
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public var shadowOpacity: Float {
//            get {
//                return layer.shadowOpacity
//            }
//            set {
//                layer.shadowOpacity = newValue
//                updateLayerEffects()
//            }
//        }
//        
//        
//        @IBInspectable public var shadowColor: UIColor? {
//            get {
//                guard let cgShadowColor = layer.shadowColor else { return nil }
//                return UIColor(cgColor: cgShadowColor)
//            }
//            set {
//                layer.shadowColor = newValue?.cgColor
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public var rotation: CGFloat {
//            get {
//                let radians = atan2(transform.b, transform.d)
//                return radians * (180.0 / CGFloat(Double.pi))
//            }
//            set {
//                let radians = newValue * (CGFloat(Double.pi) / 180.0)
//                transform = CGAffineTransform(rotationAngle: radians)
//            }
//        }
//        
//        @IBInspectable public var borderColor: UIColor? {
//            get {
//                return (layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil)
//            }
//            set {
//                layer.borderColor = newValue?.cgColor
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public var borderWidth: CGFloat {
//            get {
//                return layer.borderWidth
//            }
//            set {
//                layer.borderWidth = newValue
//                updateLayerEffects()
//            }
//        }
//        
//        public func updateLayerEffects() {
//            if shadowOpacity != 0 {
//                layer.shadowOffset  = CGSize(width: 0, height: 0);
//                layer.masksToBounds = false
//            } else if cornerRadius != 0 {
//                layer.masksToBounds = true
//            }
//        }
//        
//    }
    
//    public extension UIButton {
//    
//        @IBInspectable public override var cornerRadius: CGFloat {
//            get {
//                return layer.cornerRadius
//            }
//            set {
//                if newValue == -1 {
//                    layer.cornerRadius = self.bounds.size.width/2
//                } else {
//                    layer.cornerRadius = newValue
//                }
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public override var shadowRadius: CGFloat {
//            get {
//                return layer.shadowRadius
//            }
//            set {
//                layer.shadowRadius  = newValue;
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public override var shadowOpacity: Float {
//            get {
//                return layer.shadowOpacity
//            }
//            set {
//                layer.shadowOpacity = newValue
//                updateLayerEffects()
//            }
//        }
//        
//        
//        @IBInspectable public override var shadowColor: UIColor? {
//            get {
//                guard let cgShadowColor = layer.shadowColor else { return nil }
//                return UIColor(cgColor: cgShadowColor)
//            }
//            set {
//                layer.shadowColor = newValue?.cgColor
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public override var rotation: CGFloat {
//            get {
//                let radians = atan2(transform.b, transform.d)
//                return radians * (180.0 / CGFloat(Double.pi))
//            }
//            set {
//                let radians = newValue * (CGFloat(Double.pi) / 180.0)
//                transform = CGAffineTransform(rotationAngle: radians)
//            }
//        }
//        
//        @IBInspectable public override var borderColor: UIColor? {
//            get {
//                return (layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil)
//            }
//            set {
//                layer.borderColor = newValue?.cgColor
//                updateLayerEffects()
//            }
//        }
//        
//        @IBInspectable public override var borderWidth: CGFloat {
//            get {
//                return layer.borderWidth
//            }
//            set {
//                layer.borderWidth = newValue
//                updateLayerEffects()
//            }
//        }
//        
//        public override func updateLayerEffects() {
//            if shadowOpacity != 0 {
//                layer.shadowOffset  = CGSize(width: 0, height: 0);
//                layer.masksToBounds = false
//            } else if cornerRadius != 0 {
//                layer.masksToBounds = true
//            }
//        }
//        
//    }
    
    public extension UIView {
        
        @discardableResult
        func addParallax(amount: Int) -> UIMotionEffect {
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
        func addParallax(keyPath: String, type: UIInterpolatingMotionEffectType, amount: Int) -> UIInterpolatingMotionEffect {
            let motionEffect = UIInterpolatingMotionEffect(keyPath: keyPath, type: type)
            motionEffect.minimumRelativeValue = -amount
            motionEffect.maximumRelativeValue = amount
            self.addMotionEffect(motionEffect)
            return motionEffect
        }
        
    }
    
    public extension UIView {
        
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
    
    public extension UIViewController {
        
        public func insertChild(viewController: UIViewController, inView: UIView) {
            addChildViewController(viewController)
            viewController.willMove(toParentViewController: self)
            inView.fillWithSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
        
        public func removeChild(viewController: UIViewController) {
            viewController.removeFromParentViewController()
            viewController.willMove(toParentViewController: nil)
            viewController.view?.removeFromSuperview()
            viewController.didMove(toParentViewController: nil)
        }
        
    }
    
    public extension UITableView {
        
        func hideBottomSeparators(showLast: Bool = false) {
            let inset = separatorInset.left
            tableFooterView = UIView(frame: CGRect(x: inset, y: 0, width: frame.size.width-inset, height: 0.5))
            tableFooterView!.backgroundColor = showLast ? separatorColor : UIColor.clear
        }
        
        func showBottomSeparators() {
            tableFooterView = nil
        }
        
    }
    
#endif
