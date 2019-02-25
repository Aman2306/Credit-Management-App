//
//  ShowAlert.swift
//  Credit Management App
//
//  Created by Aman Meena on 25/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
