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


/*
 func searchWebserviceCall(categoryID:String,searchKey:String,deviceUDID:String){
     
            
            let dict = ["category_id": categoryID,"keyword":searchKey,"deviceid":deviceUDID]
            let session = URLSession.shared
            let Url = String(format: "http://ingtesting.com/games/api/search/")
            guard let serviceUrl = URL(string: Url) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    //create json object from data
                    if let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print(jsonDict)
                        
                        let responseDict = (jsonDict as NSDictionary).mutableCopy() as! NSMutableDictionary
                        let resultVal:Bool =  (responseDict.object(forKey: "status") as? Bool)!
                        
                        
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
       
        
        
    }
*/
