//
//  ComputedVariableLegacy.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/7/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class ComputedVariableLegacyTVC: SPModelTVC {
    
    private var a = 1
    private var b = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateSum()
        generateRandomEvents()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) {_ in
            self.generateRandomEvents()
        }
    }
    
    private func calculateSum() {
        let sum = "\(a) + \(b) = \(a+b)"
        self.log(log: sum)
        self.model1.value.insert(sum, at: 0)
    }
    
    private func generateRandomEvents() {
        a = Int(arc4random_uniform(10))
        calculateSum()
        b = Int(arc4random_uniform(10))
        calculateSum()
    }
    
}

extension ComputedVariableLegacyTVC {
    
    static func getVC() -> ComputedVariableLegacyTVC {
        return ComputedVariableLegacyTVC()
    }
    
}
