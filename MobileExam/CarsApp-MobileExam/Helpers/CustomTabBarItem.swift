//
//  CustomTabBarItem.swift
//  disabled-assistant-staff-ios
//
//  Created by Bogdan Pintilei on 1/22/18.
//  Copyright © 2018 Wolfpack Digital. All rights reserved.
//

import UIKit

class CustomTabBarItem: UITabBarItem {

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeAppearance()
    }
    
    private func customizeAppearance() {
        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributesForNormalState: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.darkGray
        ]
        let attributesForSelectedState: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.AppColors.orange
        ]
        self.setTitleTextAttributes(attributesForNormalState, for: .normal)
        self.setTitleTextAttributes(attributesForSelectedState, for: .selected)
    }
    
}
