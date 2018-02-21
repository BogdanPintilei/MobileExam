//
//  ObjectDetailsEditTableTableViewController.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class ObjectDetailsEditTableTableViewController: UITableViewController {

    @IBOutlet var topNameLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var statusTextField: UITextField!
    @IBOutlet var yearTextField: UITextField!
    @IBOutlet var kmTextField: UITextField!
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!

    var object = Object()
    var totalKm = Int(0)
    var shouldChangeEditButtonToSave: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillInTextFields()
        customizeUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldChangeEditButtonToSave = true
        changeSaveToEdit()
    }

    @IBAction func edit(_ sender: Any) {
        if shouldChangeEditButtonToSave! {
            changeEditToSave()
            shouldChangeEditButtonToSave = false
        } else {
            saveEditedObject()
            shouldChangeEditButtonToSave = true
            changeSaveToEdit()
        }
    }

    @IBAction func cancel(_ sender: Any) {
        fillInTextFields()
        changeSaveToEdit()
        shouldChangeEditButtonToSave = true
    }

    @IBAction func editKm(_ sender: Any) {
        let alert = UIAlertController(title: "KM", message: "How many km would you like to add?", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "km"
            textField.keyboardType = .numberPad
        }
        totalKm = object.km!
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if !(textField?.text?.isEmpty)! {
                if Int((textField?.text)!)! > 0 {
                    self.totalKm = self.totalKm + Int((textField?.text!)!)!
                }
                self.saveEditedKm()
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }

    private func saveEditedKm() {
        let editedObject = Object(
            id: object.id!,
            name: nameTextField.text,
            model: object.model,
            status: statusTextField.text,
            year: Int(yearTextField.text!),
            km: totalKm
        )
        object.km = totalKm
        LoadingView.startLoadingAnimation()
        APIClient.editObjectAttribute(object: editedObject) { succes in
            LoadingView.stopLoadingAnimation()
            if succes {
                self.kmTextField.text = String(self.totalKm)
                print("POST /modify 200")
            } else {
                print("POST /modify 404")
            }
        }
    }

    private func saveEditedObject() {
        let editedObject = Object(
            id: object.id!,
            name: nameTextField.text,
            model: object.model,
            status: statusTextField.text,
            year: Int(yearTextField.text!),
            km: object.km!
        )

        LoadingView.startLoadingAnimation()
        APIClient.editObject(object: editedObject) { succes in
            LoadingView.stopLoadingAnimation()
            if succes {
                self.topNameLabel.text = editedObject.name!
                print("POST /modify 200")
            } else {
                print("POST /modify 404")
                
            }
        }

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

    private func enableTextFields() {
        let textFields = [
            nameTextField,
            statusTextField,
            yearTextField,
            kmTextField
        ]
        Helper.applyBorderWidthAndColourToTextFields(textFields: textFields as! [UITextField])
        Helper.applyCornerRadiusTextFieldsAndAddPadding(textFields: textFields as! [UITextField])
        Helper.enableTextFields(textFields: textFields as! [UITextField])
        kmTextField.isUserInteractionEnabled = false
    }

    private func disableTextFields() {
        let textFields = [
            nameTextField,
            statusTextField,
            yearTextField,
        ]

        Helper.removeBorderWidthAndColourToTextFields(textFields: textFields as! [UITextField])
        Helper.disableTextFields(textFields: textFields as! [UITextField])
    }

    private func customizeUI() {
        disableCancelButton()
        customizeTextFields()
        addBorderToKmField()
    }

    private func customizeTextFields() {
        let textFields = [
            idTextField,
            nameTextField,
            modelTextField,
            statusTextField,
            yearTextField,
            kmTextField
        ]

        Helper.applyCornerRadiusTextFieldsAndAddPadding(textFields: textFields as! [UITextField])
    }

    private func enableCancelButton() {
        cancelButton.isEnabled = true
        cancelButton.tintColor = UIColor.white
    }

    private func disableCancelButton() {
        cancelButton.isEnabled = false
        cancelButton.tintColor = UIColor.clear
    }

    private func changeEditToSave() {
        enableCancelButton()
        enableTextFields()
        editButton.title = "Save"
    }

    private func changeSaveToEdit() {
        disableCancelButton()
        disableTextFields()
        editButton.title = "Edit"
    }

    private func addBorderToKmField() {
        let textFields = [
            kmTextField
        ]
        Helper.applyBorderWidthAndColourToTextFields(textFields: textFields as! [UITextField])
        Helper.applyCornerRadiusTextFieldsAndAddPadding(textFields: textFields as! [UITextField])
    }

}

