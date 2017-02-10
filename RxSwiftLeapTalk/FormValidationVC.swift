//
//  LegacyFormValidation.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/7/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

class FormValidationVC: UIViewController {
    
    class func getVC() -> FormValidationVC {
        let storyboard = AppStoryboard.formValidation.instance
        let vc: FormValidationVC = storyboard.instantiateViewController(withIdentifier: FormValidationVC.storyboardID) as! FormValidationVC
        return vc
    }
    
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var labelValidationMessage: UILabel!
    @IBOutlet var buttonLogin: UIButton!
}
