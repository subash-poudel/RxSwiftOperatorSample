//
//  RxFormValidationVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/7/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RxFormValidationVC: UIViewController {
    
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var labelValidationMessage: UILabel!
    @IBOutlet var buttonLogin: UIButton!
    let disposeBag = DisposeBag()
    
    static func getVC() -> RxFormValidationVC {
        let storyboard = AppStoryboard.formValidation.instance
        let vc = storyboard.instantiateViewController(withIdentifier: RxFormValidationVC.storyboardID) as! RxFormValidationVC
        return vc
    }
    
    override func viewDidLoad() {
        let userNameObservable = self.textFieldEmail.rx.text.orEmpty.map( { self.validateEmail(enteredEmail: $0)})
        let passwordObservable = self.textFieldPassword.rx.text.orEmpty.map({ self.validatePassword(password: $0)})
        let validFormObservable = Observable.combineLatest(userNameObservable, passwordObservable) {(username:Bool, password: Bool) in
            username && password
        }
        validFormObservable
            .skip(1)
            .map { data -> String in
                if data {
                    return "Form is valid"
                } else {
                    return "Form is not valid"
                }
            }
            .subscribe { event in
                switch event {
                case .next(let data):
                    self.labelValidationMessage.text = data
                    break
                default:
                    break
                }
            }.addDisposableTo(disposeBag)
        validFormObservable.bindTo(buttonLogin.rx.isEnabled).addDisposableTo(disposeBag)
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func validatePassword(password:String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return emailPredicate.evaluate(with: password)
    }

    
}
