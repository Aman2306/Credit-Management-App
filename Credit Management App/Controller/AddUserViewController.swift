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
        saveTask { (done) in
            if done {
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func checkValues(name: String, email: String, credits: String) -> Bool {
        if (name == "" || email == "" || credits == "") {
            //TODO: ALERT TO PUT HERE
            return false
        } else if (name.count < 3) {
            //TODO: ALERT TO PUT HERE
            return false
        } else if Int32(credits) == nil {
            //TODO: ALERT TO PUT HERE
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
