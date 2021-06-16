//
//  RXCollectionVC.swift
//  rxSwiftLearn
//
//  Created by Khiem on 2021-06-16.
//  Copyright © 2021 Khiem. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


struct CityObj {
    var name: String
    var id: Int
    
    static func allCase() -> [CityObj] {
        return [
            CityObj(name: "HN ", id: 1),
            CityObj(name: "KAaka", id: 2)
        ]
    }
    static func allCase1() -> [CityObj] {
        return [
            CityObj(name: "HN1 ", id: 1),
            CityObj(name: "KAaka1", id: 2)
        ]
    }
}

class RXCollectionVC: UIViewController {
    @IBOutlet weak var cl: UICollectionView!
    
    var cty = BehaviorRelay<[CityObj]>(value: CityObj.allCase())
    let diposebag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindData()
        cl.register(UINib(nibName: "RXCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RXCollectionViewCell")
        cl.rx.setDelegate(self).addDisposableTo(self.diposebag)
        // Do any additional setup after loading the view.
    }

    @IBAction func onUpdate(_ sender: Any) {
        cty.accept(CityObj.allCase1())
    }
    func bindData() {
        
        cty.asObservable()
            .bind(to: self.cl.rx.items(cellIdentifier: "RXCollectionViewCell")) {
                ( index, obj, cell) in
                if let cell = cell as? RXCollectionViewCell {
                    cell.setup(texxt: obj.name)
                }
            }
            .disposed(by: self.diposebag)
        cl.rx
            .itemSelected
            .bind { index in
                let a = index.row
                print("i", index)
                
            }
            .disposed(by: self.diposebag)
        cl.rx
          .modelSelected(CityObj.self)
          .subscribe(onNext: { model in
            print("\(model.name) was selected")
          })
            .disposed(by: self.diposebag)
    }
}
extension RXCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("aaa")
    }
}
