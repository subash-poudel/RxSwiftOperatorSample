//
//  CreateObservableTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/9/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class TransformObservableVC: SPModelTVC {
    var fruitsArray = ["apple", "mango", "banana", "pineapple", "orange", "papaya"]
    class func getVC(mode: TransformObservableRows) -> TransformObservableVC {
        let vc = TransformObservableVC()
        vc.mode = mode
        return vc
    }
    
    var mode: TransformObservableRows = .buffer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        switch mode {
        case .buffer: bufferMethod()
        case .flatMap: flatmapMethod()
        case .map: mapMethod()
        case .scan: scanMethod()
        }
    }
    
    private func bufferMethod() {
        Observable.from(fruitsArray)
            .buffer(timeSpan: 0, count: 2, scheduler: MainScheduler.instance)
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    struct AppData: ObservableConvertibleType {
        let data: String
        func asObservable() -> Observable<String> {
            return Observable.just("Appdata transformed as \(data)")
        }
    }
    /*
     Flatmap takes in an observable returns a type which itself can return an observable
     */
    private func flatmapMethod() {
        Observable.from(fruitsArray)
            .flatMap { (data) -> AppData in
            return AppData(data: data)
        }
        .subscribe { event in
            self.model1.value.append(event.debugDescription)
        }
        .addDisposableTo(disposeBag)
    }
    
    private func mapMethod() {
        Observable.from(fruitsArray)
            .map({
                "\($0) is"
            })
            .map({
                "\($0) tasty"
            })
            .map({
                AppData(data: $0)
            })
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    /*
     accumulator function with initial seed
     */
    private func scanMethod() {
        Observable<Double>
            .from([1.0, 2.0, 3.0])
            .scan(1) { (seed: Double, value: Double) -> Double in
                return seed * value
            }.subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
}
