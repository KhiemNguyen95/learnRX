//
//  RXCollectionViewCell.swift
//  rxSwiftLearn
//
//  Created by Khiem on 2021-06-16.
//  Copyright © 2021 Khiem. All rights reserved.
//

import UIKit

class RXCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
        // Initialization code
    }
    func setup(texxt: String) {
        self.lb.text = texxt
    }

}
