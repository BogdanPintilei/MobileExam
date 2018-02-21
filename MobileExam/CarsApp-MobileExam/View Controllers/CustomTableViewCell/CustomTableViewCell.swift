//
//  CustomTableViewCell.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var objectNameLabel: UILabel!
    @IBOutlet var objectIDLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var object: Object! { didSet { configureCell() } }

    private func configureCell() {
        objectNameLabel.text = object.name
        objectIDLabel.text = String(describing: object.id!)
    }

}
