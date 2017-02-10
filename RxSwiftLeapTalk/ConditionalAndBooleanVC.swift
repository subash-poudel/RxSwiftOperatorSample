//
//  CreateObservableTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/9/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

enum ConditionalAndBooleanRows: String {
    case skipUntil = "SkipUntil"
    case skipWhile = "SkipWhile"
    case takeUntil = "TakeUntil"
    case takeWhile = "TakeWhile"
    static let allRows: [ConditionalAndBooleanRows] = [.skipUntil, .skipWhile, .takeUntil, takeWhile]
}

class ConditionalAndBooleanVC: SPModelTVC {
    var array = ["apple", "mango", "banana", "pineapple", "orange", "papaya", "litchi", "melon", "berry"]
    var repeatedArray = ["1", "1", "3", "2", "2", "2", "3"]
    var numArray = [1, 2, 8, 18, 78, 900, 130]
    class func getVC(mode: ConditionalAndBooleanRows) -> ConditionalAndBooleanVC {
        let vc = ConditionalAndBooleanVC()
        vc.mode = mode
        return vc
    }
    
    var mode: ConditionalAndBooleanRows = .skipUntil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        switch mode {
        case .skipUntil: skipUntilMethod()
        case .skipWhile: skipWhileMethod()
        case .takeUntil: takeUntilMethod()
        case .takeWhile: takeWhileMethod()
        }
    }
    
    private func skipUntilMethod() {
        let subject = PublishSubject<String>()
        let skipObservable = PublishSubject<String>()
        var delay = 0.0
        for item in array {
            delay += 0.1
            let when = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: when) {
                subject.onNext(item)
            }
            DispatchQueue.main.asyncAfter(deadline: when + 0.3) {
                skipObservable.onNext(item)
            }
        }
        subject.asObservable()
            .skipUntil(skipObservable)
            .subscribe({event in
                self.model1.value.append("notSkipped \(event.debugDescription)")
            })
            .addDisposableTo(disposeBag)
    }
    // terminates after first false statement
    private func skipWhileMethod() {
        Observable.from(numArray)
            .skipWhile({ $0 <= 70 })
            .subscribe({event in
                self.model1.value.append("notSkipped \(event.debugDescription)")
            })
            .addDisposableTo(disposeBag)
    }
    // reverse of skipUntil
    private func takeUntilMethod() {
        let subject = PublishSubject<String>()
        let skipObservable = PublishSubject<String>()
        var delay = 0.0
        for item in array {
            delay += 0.1
            let when = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: when) {
                subject.onNext(item)
            }
            DispatchQueue.main.asyncAfter(deadline: when + 0.3) {
                skipObservable.onNext(item)
            }
        }
        subject.asObservable()
            .takeUntil(skipObservable)
            .subscribe({event in
                self.model1.value.append("take \(event.debugDescription)")
            })
            .addDisposableTo(disposeBag)

    }

    private func takeWhileMethod() {
        Observable.from(numArray)
            .takeWhile({ $0 <= 70 })
            .subscribe({event in
                self.model1.value.append("notSkipped \(event.debugDescription)")
            })
            .addDisposableTo(disposeBag)
    }
    
}
