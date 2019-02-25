//
//  ViewController.swift
//  Credit Management App
//
//  Created by Aman Meena on 25/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import UIKit
import CoreData

// Global Variables and Constants
let appDelegate = UIApplication.shared.delegate as? AppDelegate
var usersArray = [USER]()

class ViewController: UIViewController {

    // Constants
    let reuseID = "UserTableViewCell"
    let segueID = "SegueAddUser"
    
    // Variables
    
    
    // Outlets
    @IBOutlet weak var userTableView: UITableView!
    
    
    // Actions
    @IBAction func addButtonPressed() {
        performSegue(withIdentifier: segueID, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchyData()
        userTableView.reloadData()
    }
    
    // Functions
    func callDelegates() {
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.isHidden = true
    }
    
    func fetchyData() {
        fetchData { (done) in
            if done {
                if usersArray.count > 0 {
                    userTableView.isHidden = false
                } else {
                    userTableView.isHidden = true
                }
            } else {
                print("error" )
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! UserTableViewCell
        let user = usersArray[indexPath.row]
        cell.configureCell(name: user.userName!, email: user.userEmail!, credits: user.userCredits)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TransferCreditsViewController") as! TransferCreditsViewController
        vc.userIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // For swipe action
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteData(indexPath: indexPath)
            self.fetchyData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
}

// CoreData Extension
extension ViewController {
    func fetchData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "USER")
        do {
            usersArray = try managedContext.fetch(request) as! [USER]
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(usersArray[indexPath.row])
        
        do {
            try managedContext.save()
            //            completion(true)
        } catch {
            print(error.localizedDescription)
            //            completion(false)
        }
    }
}

