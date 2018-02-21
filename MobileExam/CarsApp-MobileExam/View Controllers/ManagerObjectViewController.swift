//
//  ManagerObjectViewController.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class ManagerObjectViewController: UIViewController {

    var cars = [Object]()
    var selectedObject = Object()
    var deletedCarId: Int?

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getObjects()
    }

    @IBAction func addObject(_ sender: Any) {
        performSegue(withIdentifier: "ShowAddObjectStoryBoardID", sender: nil)
    }

    @IBAction func deleteObject(_ sender: Any) {
        deleteObject()
        tableView.reloadData()
    }

    private func getObjects() {
        LoadingView.startLoadingAnimation()
        APIClient.getObjects { (cars) -> Void in
            LoadingView.stopLoadingAnimation()
            self.cars = cars
            print(cars.count)
            self.tableView.reloadData()
            self.cars = Helper.sortObjects(objects: cars)
        }
    }
    
    private func deleteObject() {
        showDeleteDialogue()
    }

    private func deleteObjectAPICall() {
        LoadingView.startLoadingAnimation()
        APIClient.deleteObject(id: deletedCarId!) { (succes) -> Void in
            LoadingView.stopLoadingAnimation()
            if succes {
                print("deletion succesfull")
                self.getObjects()
            } else {
                self.showAlert("Something went wrong please try again!")
            }
        }

    }

    private func showDeleteDialogue() {
        let alert = UIAlertController(title: "Delete Car", message: "Which Car do you want to delete?", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "ID"
            textField.keyboardType = .numberPad
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if !(textField?.text?.isEmpty)! {
                self.deletedCarId = Int((textField?.text)!)
                self.deleteObjectAPICall()
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNavigationObjectDetailsModalSegueID" {
            let navVC = segue.destination as! UINavigationController
            let vc = navVC.viewControllers.first as! ManagerObjectDetailsTableTableViewController
            vc.object = selectedObject
        }
    }

}

extension ManagerObjectViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: Table View Delegate & Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellID", for: indexPath) as! CustomTableViewCell
        cell.object = cars[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = cars[indexPath.row]
        performSegue(withIdentifier: "ShowNavigationObjectDetailsModalSegueID", sender: nil)
    }

}
