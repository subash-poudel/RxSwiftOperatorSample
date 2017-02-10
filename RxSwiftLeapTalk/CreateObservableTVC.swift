//
//  CreateObservableTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/9/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class CreateObservableTVC: SPModelTVC {
    
    class func getVC(mode: CreateObservableRows) -> CreateObservableTVC {
        let vc = CreateObservableTVC()
        vc.mode = mode
        return vc
    }
    
    var mode: CreateObservableRows = .create
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        switch mode {
        case .create:
            createMethod()
            break
        case .just:
            justMethod()
        case .generate:
            generateMethod()
        case .empty:
            emptyFunction()
        case .never:
            neverFunction()
        case .throwFunc:
            throwFunction()
        case .from:
            fromFunction()
        case .interval:
            intervalFunction()
        }
    }
    /*
     Note: Using create method, we are responsible for calling the next, completed and error handlers
     of the observers
    */
    private func createMethod() {
        Observable<String>
        .create { observer in
            for fruit in ["apple", "banana", "mango"] {
                observer.onNext(fruit)
            }
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribe { event in
            self.model1.value.append(event.debugDescription)
        }
        .addDisposableTo(disposeBag)
    }
    /*
     Note: Just method returns only one observable
     */
    private func justMethod() {
        Observable.just(["apple", "banana", "mango"])
        .subscribe {event in
            self.model1.value.append(event.debugDescription)
        }
        .addDisposableTo(disposeBag)
    }
    
    private func diceRoll() -> Int {
        return Int(arc4random_uniform(6)) + 1
    }
    /*
     Note: initialState start value
     condition termination condition
     iterate next element
     */
    private func generateMethod() {
        Observable.generate(
            initialState: self.diceRoll(),
            condition:{ data in
                if data == 1 {
                    return false
                } else {
                    return true
                }
            },
            iterate: { data in
                return self.diceRoll()
            })
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func emptyFunction() {
        Observable<String>.empty()
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func neverFunction() {
        Observable<String>.never()
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func throwFunction() {
        Observable<AppErr>.error(AppErr(error: "this is an error"))
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func fromFunction() {
        let arr = ["apple", "banana", "mango"]
        Observable.from(arr)
        .subscribe { event in
            self.model1.value.append(event.debugDescription)
        }
        .addDisposableTo(disposeBag)
    }
    
    private func intervalFunction() {
        Observable<Int>
            .interval(1, scheduler: MainScheduler.instance)
            .map({seconds in
                "seconds elapsed: \(seconds + 1)"
            })
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
}

struct AppErr: Error {
    let error: String
}
