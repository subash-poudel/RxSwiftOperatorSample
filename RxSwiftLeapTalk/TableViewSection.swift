//
//  TableViewRow.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

protocol TableViewSection {
    
    func numberOfRows() -> Int
    func title() -> String?
    static func numberOfSections() -> Int
    
}
