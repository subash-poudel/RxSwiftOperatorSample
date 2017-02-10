//
//  AppStoryboard.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    
    case formValidation = "FormValidation"
    case buttonTapped = "ButtonTapped"
    case userInactive = "UserInactive"
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

}
