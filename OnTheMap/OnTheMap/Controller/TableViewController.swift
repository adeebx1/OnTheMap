//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 28/11/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var studentLocation = [StudentLocation]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        OnTheMapClient.getStudentLocation() { studentLocationResults, error in
            DispatchQueue.main.async {
                self.studentLocation = studentLocationResults
                self.tableView.reloadData()
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell")!
        
        let location = self.studentLocation[indexPath.row]
        
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.detailTextLabel?.text = location.mediaURL
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = URL(string: self.studentLocation[(indexPath as NSIndexPath).row].mediaURL),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func addStudentLocationButton(_ sender: Any) {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addLocation") as! UINavigationController
        
        present(navController, animated: true, completion: nil)
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        OnTheMapClient.deleteSession(completion: handleDeletedSession(success:error:))
    }
    
    
    func handleDeletedSession(success:Bool,error:Error?){
        if success {
            DispatchQueue.main.sync {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}


