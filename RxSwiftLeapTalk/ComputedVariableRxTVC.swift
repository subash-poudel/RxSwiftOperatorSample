//
//  ComputedVariableRxTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/6/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class ComputedVariableRxTVC: SPModelTVC {
    
    private var a = Variable(1)
    private var b = Variable(2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRX()
        generateRandomEvents()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) {_ in 
            self.generateRandomEvents()
        }
    }
    
    private func setupRX() {
        let c = Observable
            .combineLatest(a.asObservable(), b.asObservable()) {
                $0 + $1
            }
            .map {
                "\(self.a.value) + \(self.b.value) = \($0)"
            }
            .subscribe { event in
                switch event {
                case .completed:
                    self.log(log: "completed")
                case .error(let error):
                    self.log(log: error.localizedDescription)
                case .next(let data):
                    self.log(log: data)
                    self.model1.value.insert(data, at: 0)
            }
        }
        c.addDisposableTo(disposeBag)
    }
    
    private func generateRandomEvents() {
        let randomA = Int(arc4random_uniform(10))
        let randomB = Int(arc4random_uniform(10))
        a.value = randomA
        b.value = randomB
    }
    
}

extension ComputedVariableRxTVC {
    
    static func getVC() -> ComputedVariableRxTVC {
        return ComputedVariableRxTVC()
    }

}
