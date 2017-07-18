//
//  ShowEmpDertailsTVC.swift
//  SavingData
//
//  Created by prasanth.podalakur on 2/1/17.
//  Copyright © 2017 KelltonTech. All rights reserved.
//

import UIKit

class ShowEmpDertailsTVC: UITableViewCell {

    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var empIDLabel: UILabel!
    @IBOutlet weak var cellSubView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
