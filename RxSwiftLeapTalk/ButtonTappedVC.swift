//
//  ButtonTappedVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/10/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ButtonTappedVC: UIViewController {
    @IBOutlet var button: UIButton!
    @IBOutlet var buttonTappedCountLabel: UILabel!
    var disposeBag = DisposeBag()
    
    class func getVC() -> ButtonTappedVC {
        let storyboard = AppStoryboard.buttonTapped.instance
        let vc = storyboard.instantiateViewController(withIdentifier: ButtonTappedVC.storyboardID) as! ButtonTappedVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.rx.tap.scan(0) { tappedTimes, newCount in
            return tappedTimes + 1
        }
        .map({ "count: \($0)" })
        .bindTo(buttonTappedCountLabel.rx.text)
        .addDisposableTo(disposeBag)
        
        // animation
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .takeUntil(button.rx.tap)
        .subscribe({ event in
            print(event)
            UIView.animate(withDuration: 0.4, animations: {
                if let number = event.element {
                    let scale: CGFloat = number % 2 == 0 ? 1.5 : 1.0
                    self.button.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            })
        })
        .addDisposableTo(disposeBag)
    }
}
