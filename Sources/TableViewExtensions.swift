//
//  TableViewExtensions.swift
//  StartAppsKitExtensionsPackageDescription
//
//  Created by Gabriel Lanata on 16/10/17.
//

#if os(iOS)
    
    import UIKit
    
    extension UITableView {
        
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
    
    extension UITableViewCell {
        
        public func autoLayoutHeight(_ tableView: UITableView? = nil) -> CGFloat {
            if let tableView = tableView { // where frame.size.width == 0 {
                frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width-13, height: 9999)
                contentView.frame = frame
            }
            layoutIfNeeded()
            let targetSize = CGSize(width: tableView!.frame.size.width-13, height: 10)
            let size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority(rawValue: 999))
            return size.height+1
        }
        
    }
    
    extension UITableView {
        
        public func hideBottomSeparator(showLast: Bool = false) {
            let inset = separatorInset.left
            tableFooterView = UIView(frame: CGRect(x: inset, y: 0, width: frame.size.width-inset, height: 0.5))
            tableFooterView!.backgroundColor = showLast ? separatorColor : UIColor.clear
        }
        
        public func showBottomSeparator() {
            tableFooterView = nil
        }
        
    }
    
    extension UITableView {
        
        public func scrollToTop(animated: Bool) {
            self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: animated)
        }
        
    }
    
#endif

