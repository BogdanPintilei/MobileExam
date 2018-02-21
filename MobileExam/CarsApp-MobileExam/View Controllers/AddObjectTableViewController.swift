//
//  AddObjectTableViewController.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class AddObjectTableViewController: UITableViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var yearTextField: UITextField!
    
    var boats = [Object]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableTextFields()
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        addObject()
    }
    
    private func addObject() {
        let object = Object(
            name: nameTextField.text,
            model: modelTextField.text,
            seats: Int(yearTextField.text!)
        )
        LoadingView.startLoadingAnimation()
        APIClient.addObject(object: object) { succes in
            LoadingView.stopLoadingAnimation()
            if succes {
                print("POST /modify 200")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("POST /modify 404")
                if ConnectivityManager.shared().isConnectedToInternet() {
                     self.showAlert("Something went wrong, please try again!")
                } else {
                    self.getObjects()

                }
            }
        }
    }
    
    private func getObjects() {
        let object = Object(
            name: nameTextField.text,
            model: modelTextField.text,
            seats: Int(yearTextField.text!)
        )
        LoadingView.startLoadingAnimation()
        APIClient.getObjects { (boats) -> Void in
            LoadingView.stopLoadingAnimation()
            self.boats = boats
            self.boats.append(object)
            Object.insertItems(objectList: self.boats)
            self.dismiss(animated: true, completion: nil)
        }
    }
    private func enableTextFields() {
        let textFields = [
            nameTextField,
            modelTextField,
            yearTextField,
        ]
        Helper.applyBorderWidthAndColourToTextFields(textFields: textFields as! [UITextField])
        Helper.applyCornerRadiusTextFieldsAndAddPadding(textFields: textFields as! [UITextField])
        Helper.enableTextFields(textFields: textFields as! [UITextField])
    }
    
}
