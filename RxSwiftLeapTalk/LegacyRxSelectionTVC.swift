//
//  LegacyRxSelectionTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

protocol LegacyRxSelectionTVCDelegate: class {
    func didSelect(row: LegacyRxSelectionRow)
}

class LegacyRxSelectionTVC: BasicTableViewController {
    var delegate: LegacyRxSelectionTVCDelegate?
    
}

extension LegacyRxSelectionTVC {
    
    static func getVC(delegate: LegacyRxSelectionTVCDelegate) -> LegacyRxSelectionTVC {
        let sections = LegacyRxSelectionSection.allSections
        let vc = LegacyRxSelectionTVC(withSections: sections, style: .grouped)
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BasicCell.self)
    }

}

// tableview datasource and delegates
extension LegacyRxSelectionTVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = LegacyRxSelectionSection.allSections[indexPath.section]
        switch section {
        case .selection:
            let row = LegacyRxSelectionRow.allRows[indexPath.row]
            switch row {
            case .rx:
                guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
                cell.label.text = "Reactive Way"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                return cell
            case .legacy:
                guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
                cell.label.text = "Normal/Common Way"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = LegacyRxSelectionSection.allSections[indexPath.section]
        switch section {
        case .selection:
            let row = LegacyRxSelectionRow.allRows[indexPath.row]
            switch row {
            case .rx:
                delegate?.didSelect(row: .rx)
            case .legacy:
                delegate?.didSelect(row: .legacy)
            }
        }
    }
    
}
