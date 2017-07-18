//
//  UpdatedDataBaseVC.swift
//  SavingData
//
//  Created by prasanth.podalakur on 2/1/17.
//  Copyright © 2017 KelltonTech. All rights reserved.
//

import UIKit
import CoreData

class UpdatedDataBaseVC: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var empIDTextField: UITextField!
    
    var employee:EmployeeDetails!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fullNameTextField.text! = self.employee.fullName!
        self.empIDTextField.text! = String(describing: self.employee.empID)
        self.companyNameTextField.text! = self.employee.company!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        self.employee.fullName = self.fullNameTextField.text!
        self.employee.empID = Int16(self.empIDTextField.text!)!
        self.employee.company = self.companyNameTextField.text!
        DataBaseController.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
