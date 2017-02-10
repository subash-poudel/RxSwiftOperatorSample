//
//  NSObject+Extension.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import Foundation

extension NSObject {

    func log(log: String?) {
        let tag = String(describing: type(of: self))
        print("\(tag) : \(log ?? "")")
    }

}
