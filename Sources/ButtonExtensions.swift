//
//  ButtonExtensions.swift
//  Pods
//
//  Created by Gabriel Lanata on 1/18/16.
//
//

//import SwifterSwift

#if os(iOS)
    
    import UIKit
    
    private var _aaak: UInt8 = 0
    private var _aiak: UInt8 = 1
    private var _toak: UInt8 = 2
    private var _etak: UInt8 = 3
    private var _bcak: UInt8 = 4
    private var _tfak: UInt8 = 5
    private var _fhsk: UInt8 = 6
    
    extension UIButton {
        
        public var image: UIImage? {
            get { return self.image(for: UIControlState()) }
            set { setImage(newValue, for: UIControlState()) }
        }
        
        public var backgroundImage: UIImage? {
            get { return self.backgroundImage(for: UIControlState()) }
            set { setBackgroundImage(newValue, for: UIControlState()) }
        }
        
        public var textColor: UIColor? {
            get { return titleColor(for: UIControlState()) }
            set { setTitleColor(newValue, for: UIControlState()) }
        }
        
        public var titleFont: UIFont? {
            get { return titleLabel?.font }
            set { titleLabel?.font = newValue }
        }
        
        public var title: String? {
            get {
                return self.title(for: UIControlState())
            }
            set {
                setTitle(newValue, for: UIControlState())
                titleOriginal = newValue
            }
        }
        
        public var tempTitle: String? {
            get {
                return (self.title(for: UIControlState()) != titleOriginal ? self.title(for: UIControlState()) : nil)
            }
            set {
                if let newValue = newValue {
                    if titleOriginal == nil { titleOriginal = title }
                    setTitle(newValue, for: UIControlState())
                } else {
                    setTitle(titleOriginal, for: UIControlState())
                }
            }
        }
        
        public var errorTitle: String? {
            get { return objc_getAssociatedObject(self, &_etak) as? String }
            set { objc_setAssociatedObject(self, &_etak, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
        }
        
        public var activityIndicatorView: UIActivityIndicatorView? {
            get { return objc_getAssociatedObject(self, &_aiak) as? UIActivityIndicatorView ?? createActivityIndicatorView() }
            set { objc_setAssociatedObject(self, &_aiak, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
        }
        
        fileprivate var titleOriginal: String? {
            get { return objc_getAssociatedObject(self, &_toak) as? String }
            set { objc_setAssociatedObject(self, &_toak, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
        }
        
        fileprivate func createActivityIndicatorView() -> UIActivityIndicatorView {
            let tempView = UIActivityIndicatorView(activityIndicatorStyle: .white)
            tempView.center    = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
            tempView.tintColor = textColor
            tempView.color     = textColor
            tempView.hidesWhenStopped = true
            activityIndicatorView = tempView
            addSubview(tempView)
            return tempView
        }
        
        override open var isHighlighted: Bool {
            didSet {
                if backgroundColorOriginal == nil { backgroundColorOriginal = backgroundColor }
                guard let alpha = backgroundColorOriginal?.alpha, alpha > 0 else { return }
                if alpha <= 0.8 {
                    backgroundColor = backgroundColorOriginal?.with(alpha: isHighlighted ? alpha+0.2 : alpha)
                } else {
                    backgroundColor = backgroundColorOriginal?.with(shadow: isHighlighted ? 0.2 : 0.0)
                }
            }
        }
        
        override open var isEnabled: Bool {
            didSet {
                if backgroundColorOriginal == nil { backgroundColorOriginal = backgroundColor }
                guard let alpha = backgroundColorOriginal?.alpha, alpha > 0 else { return }
                backgroundColor = backgroundColorOriginal?.with(alpha: isEnabled ? alpha : alpha/2.0)
            }
        }
        
        fileprivate var backgroundColorOriginal: UIColor? {
            get { return objc_getAssociatedObject(self, &_bcak) as? UIColor }
            set { objc_setAssociatedObject(self, &_bcak, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
        }
        
    }
    
    public extension UIGestureRecognizer {
        
        public convenience init(action: ((_ sender: Any) -> Void)?) {
            self.init()
            setAction(action)
        }
        
        public func setAction(_ action: ((_ sender: Any) -> Void)?) {
            if let action = action {
                self.removeTarget(self, action: nil)
                self.addTarget(self, action: #selector(performAction))
                self.closuresWrapper = ClosureWrapper(action: action)
            } else {
                self.removeTarget(self, action: nil)
                self.closuresWrapper = nil
            }
        }
        
        @objc public func performAction() {
            self.closuresWrapper?.action(self)
        }
        
        fileprivate var closuresWrapper: ClosureWrapper? {
            get { return objc_getAssociatedObject(self, &_aaak) as? ClosureWrapper }
            set { objc_setAssociatedObject(self, &_aaak, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        }
        
    }
    
    public extension UIControl {
        
        private struct AssociatedKeys {
            static var targetClosure = "targetClosure"
        }
        
        public func setAction(controlEvents: UIControlEvents, action: ((_ sender: Any) -> Void)?) {
            if let action = action {
                self.removeTarget(self, action: nil, for: controlEvents)
                self.addTarget(self, action: #selector(performAction), for: controlEvents)
                self.closuresWrapper = ClosureWrapper(action: action)
            } else {
                self.removeTarget(self, action: nil, for: controlEvents)
                self.closuresWrapper = nil
            }
        }
        
        @objc public func performAction() {
            self.closuresWrapper?.action(self)
        }
        
        fileprivate var closuresWrapper: ClosureWrapper? {
            get { return objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper }
            set { objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        }
        
    }
    
    public extension UIRefreshControl {
        
        public convenience init(color: UIColor? = nil, action: ((_ sender: Any) -> Void)?) {
            self.init()
            setAction(action)
            if let color = color {
                tintColor = color
            }
        }
        
        public func setAction(_ action: ((_ sender: Any) -> Void)?) {
            setAction(controlEvents: .valueChanged, action: action)
        }
        
    }
    
    public extension UIButton {
        
        public func setAction(_ action: @escaping ((_ sender: Any) -> Void)) {
            setAction(controlEvents: .touchUpInside, action: action)
        }
        
    }
    
    public extension UIBarButtonItem {
        
        public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, action: ((_ sender: Any) -> Void)?) {
            self.init(barButtonSystemItem: systemItem, target: nil, action: #selector(performAction))
            if let action = action {
                self.closuresWrapper = ClosureWrapper(action: action)
                self.target = self
            }
        }
        
        public convenience init(image: UIImage?, style: UIBarButtonItemStyle, action: ((_ sender: Any) -> Void)?) {
            self.init(image: image, style: style, target: nil, action: #selector(performAction))
            if let action = action {
                self.closuresWrapper = ClosureWrapper(action: action)
                self.target = self
            }
        }
        
        public convenience init(title: String?, style: UIBarButtonItemStyle, action: ((_ sender: Any) -> Void)?) {
            self.init(title: title, style: style, target: nil, action: #selector(performAction))
            if let action = action {
                self.closuresWrapper = ClosureWrapper(action: action)
                self.target = self
            }
        }
        
        @objc public func performAction() {
            self.closuresWrapper?.action(self)
        }
        
        fileprivate var closuresWrapper: ClosureWrapper? {
            get { return objc_getAssociatedObject(self, &_aaak) as? ClosureWrapper }
            set { objc_setAssociatedObject(self, &_aaak, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        }
        
    }
    
    private final class ClosureWrapper {
        fileprivate let action: (_ sender: Any) -> Void
        init(action: @escaping (_ sender: Any) -> Void) {
            self.action = action
        }
    }
    
    private final class TextFieldClosureWrapper: NSObject, UITextFieldDelegate {
        fileprivate var action: (_ sender: Any) -> Void
        init(action: @escaping (_ sender: Any) -> Void) {
            self.action = action
        }
        fileprivate func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.action(textField)
            return false
        }
    }
    
    public extension UITextField {
        
        public func setAction(returnKeyType: UIReturnKeyType?, action: ((_ sender: Any) -> Void)?) {
            if let returnKeyType = returnKeyType {
                self.returnKeyType = returnKeyType
            }
            if let action = action {
                self.textFieldClosuresWrapper = TextFieldClosureWrapper(action: action)
                self.delegate = textFieldClosuresWrapper
            } else {
                self.delegate = nil
                self.textFieldClosuresWrapper = nil
            }
        }
        
        fileprivate var textFieldClosuresWrapper: TextFieldClosureWrapper? {
            get { return objc_getAssociatedObject(self, &_tfak) as? TextFieldClosureWrapper }
            set { objc_setAssociatedObject(self, &_tfak, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        }
        
    }
    
#endif
