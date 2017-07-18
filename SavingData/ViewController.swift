//
//  ViewController.swift
//  SavingData
//
//  Created by prasanth.podalakur on 2/1/17.
//  Copyright © 2017 KelltonTech. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var empIDTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if self.fullNameTextField.text?.isEmpty == true || self.empIDTextField.text?.isEmpty == true || self.companyNameTextField.text?.isEmpty == true {
            
            showUserAlert()
            
        }
        else{
            let employee:EmployeeDetails  = NSEntityDescription.insertNewObject(forEntityName: "EmployeeDetails", into: DataBaseController.persistentContainer.viewContext) as! EmployeeDetails
            
            employee.fullName = self.fullNameTextField.text!
            employee.company  = self.companyNameTextField.text!
            employee.empID    = Int16(self.empIDTextField.text!)!
            DataBaseController.saveContext()
        }

        
        
    }
    
    @IBAction func fetchButtonTapped(_ sender: Any) {
        let FeatchRequiest:NSFetchRequest<EmployeeDetails> = EmployeeDetails.fetchRequest()
        print(FeatchRequiest)
        do{
            let employee = try DataBaseController.persistentContainer.viewContext.fetch(FeatchRequiest)
            
            for each in employee as [EmployeeDetails] {
                print("empDetails :- \(each.fullName!)\n\(each.company!)\n\(each.empID)")
            }
        }catch{
            print(" error\(error.localizedDescription)")
        }
        
        let showEmpDetailsVC = ShowEmpDetailsVC(nibName: "ShowEmpDetailsVC", bundle: nil)
        self.navigationController?.pushViewController(showEmpDetailsVC, animated: true)
    }

    
    func showUserAlert(){
        let alertController = UIAlertController(title: "SavingData", message: "Please enter All fields mandatory*", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("OK Pressed")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
