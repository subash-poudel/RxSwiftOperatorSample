//
//  CreateObservableTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/9/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

enum MathObservableRows: String {
    case concat = "Concat"
    case reduce = "Reduce"
    static let allRows: [MathObservableRows] = [.concat, .reduce]
}

class MathObservableVC: SPModelTVC {
    
    var repeatedArray = ["1", "1", "3", "2", "2", "2", "3"]
    var numArray = [1, 2, 8, 18, 78, 900, 130]
    var numArray2 = [5, 10, 15, 20, 25]
    class func getVC(mode: MathObservableRows) -> MathObservableVC {
        let vc = MathObservableVC()
        vc.mode = mode
        return vc
    }
    
    var mode: MathObservableRows = .concat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        switch mode {
        case .concat: concatMethod()
        case .reduce: reduceMethod()
        }
    }
    
    private func concatMethod() {
        Observable.from(numArray)
            .concat(Observable.from(numArray2))
            .subscribe({event in
                self.model1.value.append("\(event.debugDescription)")
            })
            .addDisposableTo(disposeBag)
    }
    // 0 is seed value
    private func reduceMethod() {
        Observable.from(numArray2)
            .reduce(0, accumulator: { (prev, final) -> Int in
                return prev + final
            })
            .subscribe({event in
                self.model1.value.append("\(event.debugDescription)")
            })
            .addDisposableTo(disposeBag)
    }

}
