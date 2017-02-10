//
//  CreateObservableTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/9/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class CombineObservableVC: SPModelTVC {
    var array = ["apple", "mango", "banana", "pineapple", "orange", "papaya", "litchi", "melon", "berry"]
    var repeatedArray = ["1", "1", "3", "2", "2", "2", "3"]
    
    class func getVC(mode: CombineObservableRows) -> CombineObservableVC {
        let vc = CombineObservableVC()
        vc.mode = mode
        return vc
    }
    
    var mode: CombineObservableRows = .zip
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        switch mode {
        case .zip: zipMethod()
        case .startWith: startWithMethod()
        case .merge: mergeMethod()
        case .combineLatest: combineLatestMethod()
        }
    }
    /*
     items emitted is the lower of them all
     */
    private func zipMethod() {
        let ob1 = Observable.from(array)
        let ob2 = Observable.from(repeatedArray)
        Observable.zip(ob1, ob2) { "\($0) + \($1)" }
        .subscribe { event in
            self.model1.value.append(event.debugDescription)
        }
        .addDisposableTo(disposeBag)
    }
    
    private func startWithMethod() {
        Observable.from(array)
        .startWith("abc", "def")
        .subscribe { event in
            self.model1.value.append(event.debugDescription)
        }
        .addDisposableTo(disposeBag)
    }
    
    private func mergeMethod() {
        let ob1 = Observable.from(array)
        let ob2 = Observable.from(repeatedArray)
        Observable.of(ob1, ob2)
        .merge()
        .subscribe { event in
            self.model1.value.append(event.debugDescription)
        }
        .addDisposableTo(disposeBag)
    }
    
    private func combineLatestMethod() {
        let ob1 = Observable.from(array)
        let ob2 = Observable.from(repeatedArray)
        Observable.combineLatest(ob1, ob2) { "source1:\($0) source2:\($1)" }
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
}
