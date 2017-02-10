//
//  MainNavigationController.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    static func getVC(rootViewController: UIViewController) -> MainNavigationController {
        let mainNavController = MainNavigationController(rootViewController: rootViewController)
        mainNavController.navigationBar.barTintColor = UIColor.orange
        return mainNavController
    }
    
}
