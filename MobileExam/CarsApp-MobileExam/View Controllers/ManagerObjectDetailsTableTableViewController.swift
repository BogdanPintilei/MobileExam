//
//  ManagerObjectDetailsTableTableViewController.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class ManagerObjectDetailsTableTableViewController: UITableViewController {

    @IBOutlet var topNameLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var statusTextField: UITextField!
    @IBOutlet var yearTextField: UITextField!
    @IBOutlet var kmTextField: UITextField!

    var object = Object()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillInTextFields()
        disableTextFields()
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    private func fillInTextFields() {
        topNameLabel.text = object.name!
        idTextField.text = "\(object.id!)"
        nameTextField.text = object.name!
        modelTextField.text = object.model!
        statusTextField.text = object.status!
        yearTextField.text = "\(object.year!)"
        kmTextField.text = "\(object.km!)"
    }
    
    
    private func disableTextFields() {
        let textFields = [
            idTextField,
            nameTextField,
            statusTextField,
            modelTextField,
            statusTextField,
            yearTextField,
            kmTextField
        ]
        
        Helper.disableTextFields(textFields: textFields as! [UITextField])
    }
    
}
