//
//  DashboardSection.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

enum DashboardSection: TableViewSection {
    
    case math, create, basics, formValidation, transform, filter, combine, errorHandling, conditionalAndBoolean, buttonTapped, userInactive
    
    static let allSections: [DashboardSection] = [create, transform, filter, combine, math, errorHandling, conditionalAndBoolean, basics, formValidation, buttonTapped, userInactive]
    func numberOfRows() -> Int {
        switch self {
        case .create:
            return CreateObservableRows.allRows.count
        case .basics:
            return BasicDashboardRows.allRows.count
        case .formValidation:
            return FormValidation.allRows.count
        case .transform:
            return TransformObservableRows.allRows.count
        case .filter:
            return FilterObservableRows.allRows.count
        case .combine:
            return CombineObservableRows.allRows.count
        case .errorHandling:
            return ErrorHandlingRows.allRows.count
        case .conditionalAndBoolean:
            return ConditionalAndBooleanRows.allRows.count
        case .math:
            return MathObservableRows.allRows.count
        case .buttonTapped:
            return 1
        case .userInactive:
            return 1
        }
    }
    
    func title() -> String? {
        switch self {
        case .filter:
            return "Filtering Observables"
        case .create:
            return "Creating Observables"
        case .basics:
            return "Basics"
        case .formValidation:
            return "Form Validation"
        case .transform:
            return "Transforming Observables"
        case .combine:
            return "Combining Observables"
        case .errorHandling:
            return "Error Handling"
        case .conditionalAndBoolean:
            return "Conditional and Boolean Observables"
        case .math:
            return "Mathematical Operators"
        case .buttonTapped:
            return "Button Tapped"
        case .userInactive:
            return "User Inactive"
        }
    }
    
    static func numberOfSections() -> Int {
        return allSections.count
    }

}

enum ErrorHandlingRows: String {
    case catchError = "CatchError"
    case catchErrorJustReturn = "CatchErrorJustReturn"
    case retry = "Retry"
    static let allRows:[ErrorHandlingRows] = [.catchError, catchErrorJustReturn, .retry]
}

enum CombineObservableRows: String {
    case zip = "Zip"
    case startWith = "StartWith"
    case merge = "Merge"
    case combineLatest = "CombineLatest"
    static let allRows: [CombineObservableRows] = [.zip, .startWith, .merge, .combineLatest]
}

enum FilterObservableRows: String {
    case filter = "Filter"
    case single = "single"
    case debounce = "Debounce"
    case distinct = "Distinct"
    case elementAt = "ElementAt"
    case take = "Take"
    case sample = "Sample"
    static let allRows: [FilterObservableRows] = [.filter, .single, .debounce, .distinct, .elementAt, .take, .sample]
}

enum TransformObservableRows: String {
    case buffer = "Buffer"
    case flatMap = "FlatMap"
    case map = "Map"
    case scan = "Scan"
    static let allRows: [TransformObservableRows] = [.buffer, .flatMap, .map, .scan]
}

enum CreateObservableRows: String {
    case create = "Create"
    case just = "Just"
    case generate = "Generate"
    case empty = "Empty"
    case never = "Never"
    case throwFunc = "Throw"
    case from = "From"
    case interval = "Interval"
    static let allRows: [CreateObservableRows] = [.create, .just, .generate, .empty, .never, .throwFunc, .from, .interval]
}

enum BasicDashboardRows {

    case calculateVariables

    static let allRows: [BasicDashboardRows] = [calculateVariables]
}

enum FormValidation {
    
    case formValidation
    
    static let allRows: [FormValidation] = [formValidation]
}
