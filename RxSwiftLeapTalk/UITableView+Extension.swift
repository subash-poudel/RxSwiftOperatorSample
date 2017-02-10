//
//  UITableView+Extension.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

// MARK: NibLoadable and ReusableView
protocol NibLoadableView: class {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: Bundle.main)
    }
}

protocol ReusableView: class {
    
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: extensions to UITableView and UITableViewCell
extension UITableViewCell: ReusableView {
    
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerClass<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T? where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
}

extension UIView: NibLoadableView {
    
}
