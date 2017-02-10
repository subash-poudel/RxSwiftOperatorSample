//
//  LegacyFormValidationVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/7/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

class LegacyFormValidationVC: UIViewController {
    
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var labelValidationMessage: UILabel!
    @IBOutlet var buttonLogin: UIButton!

    static func getVC() -> LegacyFormValidationVC {
        let storyboard = AppStoryboard.formValidation.instance
        let vc = storyboard.instantiateViewController(withIdentifier: LegacyFormValidationVC.storyboardID) as! LegacyFormValidationVC
        return vc
    }
    
    override func viewDidLoad() {
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
    }
    
}

extension LegacyFormValidationVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let password = textFieldPassword.text, let email = textFieldEmail.text else {
            labelValidationMessage.text = "Form is not valid"
            return true
        }
        let validPassword = validatePassword(password: password)
        let validEmail = validateEmail(enteredEmail: email)
        if validEmail && validPassword {
            labelValidationMessage.text = "Form is valid"
        } else {
            labelValidationMessage.text = "Form is not valid"
        }
        return true
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
