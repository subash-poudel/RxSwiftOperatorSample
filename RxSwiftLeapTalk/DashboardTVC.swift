//
//  DashboardVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

class DashboardTVC: BasicTableViewController {
    
    static func getVC() -> DashboardTVC {
        let sections = DashboardSection.allSections
        let vc = DashboardTVC(withSections: sections, style: .grouped)
        return vc
    }
    
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DashBoard"
        tableView.register(BasicCell.self)
    }
    
    override func selectedRow(row: LegacyRxSelectionRow) {
        guard  let indexPath = self.indexPath else {
            return
        }
        let section = DashboardSection.allSections[indexPath.section]
        switch row {
        case .rx:
            switch section {
            case .basics:
                let vc = ComputedVariableRxTVC.getVC()
                self.navigationController?.pushViewController(vc, animated: true)
            case .formValidation:
                let vc = RxFormValidationVC.getVC()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        case .legacy:
            switch section {
            case .basics:
                let vc = ComputedVariableLegacyTVC.getVC()
                self.navigationController?.pushViewController(vc, animated: true)
            case .formValidation:
                let vc = LegacyFormValidationVC.getVC()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
    
}

// tableview datasource and delegates
extension DashboardTVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = DashboardSection.allSections[indexPath.section]
        switch section {
        case .math:
            let row = MathObservableRows.allRows[indexPath.row]
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = row.rawValue
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .conditionalAndBoolean:
            let row = ConditionalAndBooleanRows.allRows[indexPath.row]
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = row.rawValue
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .errorHandling:
            let row = ErrorHandlingRows.allRows[indexPath.row]
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = row.rawValue
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .combine:
            let row = CombineObservableRows.allRows[indexPath.row]
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = row.rawValue
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .filter:
            let row = FilterObservableRows.allRows[indexPath.row]
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = row.rawValue
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .transform:
            let row = TransformObservableRows.allRows[indexPath.row]
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = row.rawValue
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .create:
            let row = CreateObservableRows.allRows[indexPath.row]
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = row.rawValue
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .basics:
            let row = BasicDashboardRows.allRows[indexPath.row]
            switch row {
            case .calculateVariables:
                guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
                cell.label.text = "Computed Variables"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                return cell
            }
        case .formValidation:
            let row = FormValidation.allRows[indexPath.row]
            switch row {
            case .formValidation:
                guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
                cell.label.text = "Form Validation"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                return cell
            }
        case .buttonTapped:
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = "Button Tapped"
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case .userInactive:
            guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
            cell.label.text = "User Inactive"
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        let section = DashboardSection.allSections[indexPath.section]
        switch section {
        case .math:
            let row = MathObservableRows.allRows[indexPath.row]
            let vc = MathObservableVC.getVC(mode: row)
            self.navigationController?.pushViewController(vc, animated: true)
        case .conditionalAndBoolean:
            let row = ConditionalAndBooleanRows.allRows[indexPath.row]
            let vc = ConditionalAndBooleanVC.getVC(mode: row)
            self.navigationController?.pushViewController(vc, animated: true)
        case .errorHandling:
            let row = ErrorHandlingRows.allRows[indexPath.row]
            let vc = ErrorHandlingObservableVC.getVC(mode: row)
            self.navigationController?.pushViewController(vc, animated: true)
        case .combine:
            let row = CombineObservableRows.allRows[indexPath.row]
            let vc = CombineObservableVC.getVC(mode: row)
            self.navigationController?.pushViewController(vc, animated: true)
        case .filter:
            let row = FilterObservableRows.allRows[indexPath.row]
            let vc = FilterObservableVC.getVC(mode: row)
            self.navigationController?.pushViewController(vc, animated: true)
        case .transform:
            let row = TransformObservableRows.allRows[indexPath.row]
            let vc = TransformObservableVC.getVC(mode: row)
            self.navigationController?.pushViewController(vc, animated: true)
        case .create:
            let row = CreateObservableRows.allRows[indexPath.row]
            let vc = CreateObservableTVC.getVC(mode: row)
            self.navigationController?.pushViewController(vc, animated: true)
        case .basics:
            let row = BasicDashboardRows.allRows[indexPath.row]
            switch row {
            case .calculateVariables:
                let vc = LegacyRxSelectionTVC.getVC(delegate: self)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .formValidation:
            let row = FormValidation.allRows[indexPath.row]
            switch row {
            case .formValidation:
                let vc = LegacyRxSelectionTVC.getVC(delegate: self)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .buttonTapped:
            let vc = ButtonTappedVC.getVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .userInactive:
            let vc = UserInactiveVC.getVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
