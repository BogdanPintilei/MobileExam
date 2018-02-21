//
//  CustomObjectTableViewController.swift
//  CarsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class CustomObjectTableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    static var retryInternetConnection: UIBarButtonItem!
    
    var cars = [Object]()
    var selectedObject = Object()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        getObjects()
    }
    
    private func getObjects() {
        LoadingView.startLoadingAnimation()
        APIClient.getObjects { (cars) -> Void in
            LoadingView.stopLoadingAnimation()
            self.cars = cars
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowObjectDetailsSegueID" {
            let vc = segue.destination as! ObjectDetailsEditTableTableViewController
            vc.object = selectedObject
        }
    }

}

extension CustomObjectTableViewController: UITableViewDelegate, UITableViewDataSource {

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
        performSegue(withIdentifier: "ShowObjectDetailsSegueID", sender: nil)
    }

}
