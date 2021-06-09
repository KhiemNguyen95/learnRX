//
//  NaviVC.swift
//  rxSwiftLearn
//
//  Created by Khiem on 2020-06-10.
//  Copyright © 2020 Khiem. All rights reserved.
//

import UIKit

class NaviVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var arr: [String] = ["Search", "textFieldChage"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "CityCell")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}
extension NaviVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.lbCity?.text = arr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = UIViewController()
        switch indexPath.row {
        case 0:
            vc = SearchVC()
        case 1:
            vc = TextFieldChangeVC()
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
