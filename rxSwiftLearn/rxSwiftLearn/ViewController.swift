//
//  ViewController.swift
//  rxSwiftLearn
//
//  Created by Khiem on 2019-11-01.
//  Copyright © 2019 Khiem. All rights reserved.
//

import UIKit
import RxSwift
let RANGE_TIME_RELOAD:RxTimeInterval = RxTimeInterval.milliseconds(5000)
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["Oklahoma", "Chicago", "Moscow", "Danang", "Vancouver", "Praga"]
    let obj = Observable.from(["data1","data2","data4","data3"])
    var rxSearch = BehaviorSubject<String>(value: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "CityCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        setupRX()
        // Do any additional setup after loading the view.
    }
    
    func setupRX() {
        rxSearch
            .debounce(RANGE_TIME_RELOAD, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (searchStr) in
                if searchStr.isEmpty
                {
                    self.shownCities = self.allCities
                }
                else
                {
                    self.shownCities = self.allCities.filter({ (item) -> Bool in
                        return item.contains(searchStr)
                    })
                }
                
                self.tableView.reloadData()
            }, onError: { (e) in
                
            }, onCompleted: {
                
            }) {
                
        }
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.lbCity?.text = shownCities[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //self.rxSearch.onNext("searchBar.text ?? """)
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.rxSearch.onNext(searchText)
    }
}
