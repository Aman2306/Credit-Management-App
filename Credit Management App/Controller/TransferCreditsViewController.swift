//
//  TransferCreditsViewController.swift
//  Credit Management App
//
//  Created by Aman Meena on 25/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import UIKit

class TransferCreditsViewController: UIViewController {

    // Outlets
    @IBOutlet weak var transferCreditsTableView: UITableView!
    @IBOutlet weak var creditsToTranferTextField: UITextField!
    @IBOutlet weak var selectUserButton: UIButton!
    
    
    // Variables
    var index = 0
    var userIndex = 0
    // Constants
    let cellID = "TransferCreditsCell"
    
    
    // Actions
    @IBAction func transferCreditsTapped() {
        if checkValues(senderIndex: userIndex, receiverIndex: index) {
            usersArray[index].userCredits = usersArray[index].userCredits + Int32(creditsToTranferTextField.text!)!
            usersArray[userIndex].userCredits = usersArray[userIndex].userCredits - Int32(creditsToTranferTextField.text!)!
            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            
            do {
                try managedContext.save()
                //            completion(true)
            } catch {
                print(error.localizedDescription)
                //            completion(false)
            }
            navigationController?.popViewController(animated: true)
        } else {
            
        }
    }
    
    @IBAction func selectUserTapped() {
        if transferCreditsTableView.isHidden {
            animate(toggle: true)
        } else {
            animate(toggle: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
        transferCreditsTableView.isHidden = true
    }
    
    func callDelegates() {
        transferCreditsTableView.delegate = self
        transferCreditsTableView.dataSource = self
    }
    
    func animate(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.4) {
                self.transferCreditsTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.transferCreditsTableView.isHidden = true
            }
        }
    }
    
    func checkValues(senderIndex: Int, receiverIndex: Int) -> Bool {
        if (usersArray[senderIndex].userName == usersArray[receiverIndex].userName) {
            showAlert(title: "Same user", message: "Please select different user")
            return false
        } else if (Int32(creditsToTranferTextField.text!) == nil) {
            showAlert(title: "Invalid Input", message: "Please check your input and try again.")
            return false
        } else if (usersArray[senderIndex].userCredits < Int32(creditsToTranferTextField.text!)!) {
            showAlert(title: "Not enough credits", message: "Sender does not have enough credits to make this transition.")
            return false
        } else if !(Int32(creditsToTranferTextField.text!)! > 1) {
            showAlert(title: "Invalid input", message: "Please fill valid crdit value")
        } else {
            return true
        }
        return true
    }
}

extension TransferCreditsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transferCreditsTableView.dequeueReusableCell(withIdentifier: cellID) as! TransferCreditsTableViewCell
        let user = usersArray[indexPath.row]
        cell.configureCell(name: user.userName!, credits: user.userCredits)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectUserButton.setTitle(usersArray[indexPath.row].userName, for: .normal)
        index = indexPath.row
        animate(toggle: false)
    }
    
}
