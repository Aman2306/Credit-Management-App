//
//  AddUserViewController.swift
//  Credit Management App
//
//  Created by Aman Meena on 25/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import UIKit
import CoreData

class AddUserViewController: UIViewController {

    // Outlets
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var creditsOutlet: UITextField!
    
    
    // Variables
    
    
    // Constants
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func createUserTapped(_ sender: Any) {
        if checkValues(name: nameOutlet.text, email: emailOutlet.text, credits: creditsOutlet.text) {
            saveTask { (done) in
                if done {
                    navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    // Functions
    func checkValues(name: String?, email: String?, credits: String?) -> Bool {
        if (nameOutlet.text == nil || emailOutlet.text == nil || Int32(creditsOutlet.text!) == nil) {
            showAlert(title: "Error", message: "Please fill all the fields correctly")
            return false
        }
        else if (name == "" || email == "" || credits == "") {
            showAlert(title: "Missing Values", message: "Please fill all the fields.")
            return false
        } else if (name!.count < 3) {
            showAlert(title: "Name too short", message: "Length of user name should be more than 3 characters.")
            return false
        } else if Int32(credits!) == nil {
            showAlert(title: "Invalid Input", message: "Please check credit value and try again.")
            return false
        }
        return true
    }
    
    func saveTask(completion: (_  finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let user = USER(context: managedContext)
        
        if checkValues(name: nameOutlet.text!, email: emailOutlet.text!, credits: creditsOutlet.text!) {
            user.userName = nameOutlet.text!
            user.userEmail = emailOutlet.text!
            user.userCredits = Int32(creditsOutlet.text!)!
        }
        do {
            try managedContext.save()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
}
