//
//  BasicTableViewController.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

class BasicTableViewController: UITableViewController {
    var sections: [TableViewSection]
    
    init(withSections sections: [TableViewSection], style: UITableViewStyle) {
        self.sections = sections
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method is overridden by child class as not to repeat the extension in every class
    func selectedRow(row: LegacyRxSelectionRow) {
        
    }
    
}

// tableview datasource and delegates
extension BasicTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title()
    }

}

extension BasicTableViewController: LegacyRxSelectionTVCDelegate {
    
    func didSelect(row: LegacyRxSelectionRow) {
        selectedRow(row: row)
    }
    
}
