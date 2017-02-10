//
//  CreateObservableTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/9/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class FilterObservableVC: SPModelTVC {
    var array = ["apple", "mango", "banana", "pineapple", "orange", "papaya", "1", "2", "Nepal"]
    var repeatedArray = ["1", "1", "3", "2", "2", "2", "3"]
    
    class func getVC(mode: FilterObservableRows) -> FilterObservableVC {
        let vc = FilterObservableVC()
        vc.mode = mode
        return vc
    }
    
    var mode: FilterObservableRows = .filter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        switch mode {
        case .filter: filterMethod()
        case .single: singleMethod()
        case .debounce: debounceMethod()
        case .distinct: distinctMethod()
        case .elementAt: elementAtMethod()
        case .take: takeMethod()
        case .sample: sampleMethod()
        }
    }
    
    private func filterMethod() {
        Observable.from(array)
            .filter({ data -> Bool in
                return data.contains("ap")
            })
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    // first in most rx extensions
    private func singleMethod() {
        Observable.from(array)
            .single()
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    
    
    private func debounceMethod() {
        let subject = PublishSubject<String>()
        subject.asObservable()
        .debounce(1, scheduler: MainScheduler.instance)
        .subscribe({event in
            self.model1.value.append(event.debugDescription)
        })
        .addDisposableTo(disposeBag)
        var delay = 1.0
        for item in array {
            delay += 1.5
            let when = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: when) {
                subject.onNext(item)
            }
        }
    }
    
    private func distinctMethod() {
        Observable.from(repeatedArray)
            .distinctUntilChanged()
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func elementAtMethod() {
        Observable.from(repeatedArray)
            .elementAt(4)
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func takeMethod() {
        Observable.from(array)
            .take(3)
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func sampleMethod() {
        let subject = PublishSubject<String>()
        let sampleSubject = PublishSubject<String>()
        var delay = 0.0
        for item in array {
            delay += 0.1
            let when = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: when) {
                subject.onNext(item)
            }
            DispatchQueue.main.asyncAfter(deadline: when + 0.3) {
                sampleSubject.onNext(item)
            }
        }
        sampleSubject.asObservable()
            .sample(subject)
            .subscribe({event in
                self.model1.value.append("sample \(event.debugDescription)")
            })
            .addDisposableTo(disposeBag)

    }
    
}
