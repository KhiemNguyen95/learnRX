//
//  CollectionVC.swift
//  rxSwiftLearn
//
//  Created by Khiem on 2021-06-16.
//  Copyright © 2021 Khiem. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class CollectionVC: UIViewController {
    var cl = UICollectionView(frame: CGRect(x: 0, y: 50, width: 200, height: 90),collectionViewLayout: UICollectionViewLayout())
    
    var cty = BehaviorRelay<[String]>(value: ["aa", "cccc"])
    let diposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cl.backgroundColor = .red
        self.view.addSubview(cl)
        // Do any additional setup after loading the view.
        self.bindData()
    }
    
    func bindData() {
        let cities = Observable.of(["Lisbon", "Copenhagen", "London", "Madrid",
       "Vienna"])
        cty.asObservable()
            .bind(to: self.cl.rx.items(cellIdentifier: "RXCollectionViewCell")) {
                ( cl, index, element) in
                let cell = UITableViewCell(style: .default, reuseIdentifier:
                                            "RXCollectionViewCell") as? RXCollectionViewCell
            }
            .disposed(by: self.diposebag)
        
    }
}
