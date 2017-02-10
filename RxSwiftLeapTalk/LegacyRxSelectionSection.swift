//
//  LegacyRxSelectionSection.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

enum LegacyRxSelectionSection: TableViewSection {
    
    case selection
    
    static let allSections: [LegacyRxSelectionSection] = [selection]
    
    func numberOfRows() -> Int {
        switch self {
        case .selection:
            return LegacyRxSelectionRow.allRows.count
        }
    }
    
    func title() -> String? {
        switch self {
        case .selection:
            return "Select a type"
        }
    }
    
    static func numberOfSections() -> Int {
        return allSections.count
    }

}

enum LegacyRxSelectionRow {
    
    case legacy
    case rx
    
    static let allRows: [LegacyRxSelectionRow] = [legacy, rx]
    
}
