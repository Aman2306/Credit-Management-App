//
//  TransferCreditsTableViewCell.swift
//  Credit Management App
//
//  Created by Aman Meena on 25/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import UIKit

class TransferCreditsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transferCreditsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(name: String, credits: Int32) {
        print("Check 1\nconfigue cell called")
        nameLabel.text = name
        transferCreditsLabel.text = String(credits)
    }
}
