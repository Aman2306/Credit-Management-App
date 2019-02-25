//
//  UserTableViewCell.swift
//  Credit Management App
//
//  Created by Aman Meena on 25/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    @IBOutlet weak var creditsOutlet: UILabel!
    
    
    // Variables
    
    
    // Constants
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(name: String, email: String, credits: Int32) {
        nameOutlet.text = name
        emailOutlet.text = email
        creditsOutlet.text = String(credits)
    }
}
