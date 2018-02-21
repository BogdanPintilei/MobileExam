//
//  CustomObjectTableViewController.swift
//  boatsApp-MobileExam
//
//  Created by Bogdan Pintilei on 2/20/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class CustomObjectTableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    static var retryInternetConnection: UIBarButtonItem!
    
    var boats = [Object]()
    var selectedObject = Object()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        getObjects()
    }
    
    private func getObjects() {
        LoadingView.startLoadingAnimation()
        APIClient.getObjects { (boats) -> Void in
            LoadingView.stopLoadingAnimation()
            self.boats = boats
            self.tableView.reloadData()
            if boats.isEmpty {
                self.showAlert("Something went wrong!")
            }
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
        return boats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellID", for: indexPath) as! CustomTableViewCell
        cell.object = boats[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = boats[indexPath.row]
        performSegue(withIdentifier: "ShowObjectDetailsSegueID", sender: nil)
    }

}
