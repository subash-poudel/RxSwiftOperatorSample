//
//  CreateObservableTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/9/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class ErrorHandlingObservableVC: SPModelTVC {
    var array = ["apple", "mango", "banana", "pineapple", "orange", "papaya", "litchi", "melon", "berry"]
    var repeatedArray = ["1", "1", "3", "2", "2", "2", "3"]
    
    class func getVC(mode: ErrorHandlingRows) -> ErrorHandlingObservableVC {
        let vc = ErrorHandlingObservableVC()
        vc.mode = mode
        return vc
    }
    
    var mode: ErrorHandlingRows = .catchError
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        switch mode {
        case .catchError: catchErrorMethod()
        case .catchErrorJustReturn: catchErrorJustReturnMethod()
        case .retry: retryMethod()
        }
    }
    
    private func catchErrorMethod() {
        Observable<String>
            .create { observer in
                for fruit in ["apple", "banana", "mango"] {
                    observer.onNext(fruit)
                }
                observer.onError(AppError(errorMessage: "Api Error"))
                observer.onCompleted()
                return Disposables.create()
            }
            .catchError({ appError -> Observable<String> in
                if appError is AppError {
                    return Observable.just((appError as! AppError).errorMessage)
                }
                return Observable.just(appError.localizedDescription)
            })
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func catchErrorJustReturnMethod() {
        Observable<String>
            .create { observer in
                for fruit in ["apple", "banana", "mango"] {
                    observer.onNext(fruit)
                }
                observer.onError(AppError(errorMessage: "Api Error"))
                observer.onCompleted()
                return Disposables.create()
            }
            .catchErrorJustReturn("Api Failed. Unable to continue.")
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)

    }
    
    private func retryMethod() {
        var createError = true
        Observable<String>
            .create { observer in
                for (index, element) in self.array.enumerated() {
                    observer.onNext(element)
                    if index == 5 && createError {
                        createError = false
                        observer.onError(AppError(errorMessage: "Api Error"))
                    }
                }
                observer.onCompleted()
                return Disposables.create()
            }
            .retry()
            .subscribe { event in
                self.model1.value.append(event.debugDescription)
            }
            .addDisposableTo(disposeBag)
        
    }

}

struct AppError: Error {
    let errorMessage: String
}
