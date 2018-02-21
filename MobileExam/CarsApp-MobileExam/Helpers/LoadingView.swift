//
//  LoadingView.swift
//  LanguagesApp
//
//  Created by Bogdan Pintilei on 12/19/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit

class LoadingView: UIView {
    
    static let indicatorView = NVActivityIndicatorView(frame: CGRect.zero, type: .lineScale, color: UIColor.AppColors.orange, padding: 30)
    
    static let win: UIWindow = UIApplication.shared.delegate!.window!!

    static func startLoadingAnimation() {
        indicatorView.center = win.center
        win.addSubview(indicatorView)
        indicatorView.startAnimating()
    }
    
    static func stopLoadingAnimation() {
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }
    
    static func setLoadingViewColor(color: UIColor) {
        indicatorView.color = color
    }
    
}
