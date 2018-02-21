//
//  ViewControllerExtension.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(_ message: String) {
        showAlert(message, andTitle: "")
    }
    
    func showAlert(_ message: String, andTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String? = nil, message: String? = nil, cancelButtonTitle: String? = "OK", actions: [UIAlertAction], cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = simpleAlertController(
            title: title,
            message: message,
            cancelButtonTitle: cancelButtonTitle!,
            cancelHandler: cancelHandler
        )
        
        for action in actions {
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func simpleAlertController(
        title: String? = nil,
        message: String? = nil,
        cancelButtonTitle: String = "Cancel",
        cancelHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { action in
            if let handler = cancelHandler {
                handler(action)
            }
        })
        
        alertController.addAction(cancelButton)
        
        return alertController
    }
}
