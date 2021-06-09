//
//  TextFieldChangeVC.swift
//  rxSwiftLearn
//
//  Created by Khiem on 2020-06-10.
//  Copyright © 2020 Khiem. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class TextFieldChangeVC: UIViewController {
    @IBOutlet weak var txt: UITextField!
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var login: UIButton!

    var viewModel = TextFieldChangeModel()
    let diposebag = DisposeBag()
    
    
    var sigObs = Observable.just("helo")
    //from for array
    var arrFrom = Observable.from([1,1,2,3])
    
    
    var be = BehaviorRelay<String>(value: "22")
    
    var pushString = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        customView.backgroundColor = UIColor.red
        txt.inputAccessoryView = customView
        
        txt.rx.text.map { $0 ?? "" }
            .bind(to: pushString)
            .disposed(by: self.diposebag)
        txt1.rx.text.map {$0 ?? ""}
            .bind(to: viewModel.inputText1)
            .disposed(by: self.diposebag)
        viewModel.textObservable.subscribe(onNext: { (str) in
            self.lb.text = str
        }).disposed(by: self.diposebag)
        
        viewModel.isValid
            .bind(to: login.rx.isEnabled)
            .disposed(by: self.diposebag)
        
//        self.subscribeL()
        pub()
        
        pushString.onNext("kakaa")
      
    }
    
    func subscribeL() {
        let subArr = Observable.of("kaka")
        
        let sub = sigObs.subscribe { (te) in
            print(te)
        }.disposed(by: self.diposebag)
        
        sigObs.bind(to: self.be).disposed(by: self.diposebag)
        print("be 2",be.value)
        
        
        let helloSequence = Observable.from(["H","e","l","l","o"])
        let _ = helloSequence.subscribe { event in
          switch event {
              case .next(let value):
                  print(value)
              case .error(let error):
                  print(error)
              case .completed:
                  print("completed")
          }
        }.disposed(by: self.diposebag)
        
        let intArr = Observable.from([1,3,8,5,7,4,2])
    }
    
    
    func pub() {
        let subscription1 = pushString.subscribe(onNext:{
            print(#line,$0)
        }).disposed(by: self.diposebag)
    }
    
    @IBAction func loginPress() {
        print("login")
    }
}
final class TextFieldChangeModel {
    var inputText = BehaviorRelay<String>(value: "")
    var inputText1 = BehaviorRelay<String>(value: "")
    var textObservable: Observable<String> {
//        return inputText.asObservable()
        return Observable.combineLatest(inputText.asObservable(), inputText1.asObservable()) { texxt, texxt1 in
            return texxt + texxt1
        }
    }
    var isValid: Observable<Bool> {
        return Observable.combineLatest(inputText.asObservable(), inputText1.asObservable()) { texxt, texxt1 in
            return texxt.count > 1 && texxt1.count > 3
        }
    }
}
enum API: String {
    static let base = "base"
    case login = "Login"
    
    var full: String {
        return API.base + self.rawValue
    }
}
