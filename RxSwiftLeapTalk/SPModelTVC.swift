//
//  SPModelTVC.swift
//  RxSwiftLeapTalk
//
//  Created by Subash Poudel on 2/7/17.
//  Copyright © 2017 leapfrog. All rights reserved.
//

import UIKit
import RxSwift

class SPModelTVC: UITableViewController {
    
    var model1: Variable<[String]>!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model1 = Variable([])
        tableView.register(BasicCell.self)
        model1.asObservable().subscribe { data in
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)
    }
    
}

extension SPModelTVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BasicCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
        cell.label.text = model1.value[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model1.value.count
    }
    
}


