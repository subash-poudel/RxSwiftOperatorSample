//
//  UserInactiveVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/10/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserInactiveVC: UIViewController {
    let disposeBag = DisposeBag()
    
    class func getVC() -> UserInactiveVC {
        let storyboard = AppStoryboard.userInactive.instance
        let vc = storyboard.instantiateViewController(withIdentifier: UserInactiveVC.storyboardID) as! UserInactiveVC
        return vc
    }
    
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = button.rx.tap
            .map { _ in AppEvent.tap }
        
        var tapOrTimeout = tap
            .timeout(3, scheduler: MainScheduler.instance)
            .catchError { (error) -> Observable<AppEvent> in
                return Observable.just(AppEvent.timeout)
        }.retry()
        
        let obs = Observable.of(tapOrTimeout, tap).concat()
        obs.subscribe({ event in
                switch event {
                case .completed:
                    print("completed")
                case .error(let error):
                    print("error \(error)")
                case .next(let element):
                    switch element {
                    case .tap:
                        self.buttonTapped()
                    case .timeout:
                        self.showAlert()
                        tapOrTimeout = tapOrTimeout.retry()
                    }
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func buttonTapped() {
        log(log: "Button Tapped")
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Hello", message: "You are inactive", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

enum AppEvent {
    case tap
    case timeout
}

