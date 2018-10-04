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

/*
import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authenticationWithTouchID()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"

        var authError: NSError?
        let reasonString = "To access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    
                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
                case LAError.biometryNotAvailable.rawValue:
                    message = "Authentication could not start because the device does not support biometric authentication."
                
                case LAError.biometryLockout.rawValue:
                    message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
                case LAError.biometryNotEnrolled.rawValue:
                    message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
                default:
                    message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
                case LAError.touchIDLockout.rawValue:
                    message = "Too many failed attempts."
                
                case LAError.touchIDNotAvailable.rawValue:
                    message = "TouchID is not available on the device"
                
                case LAError.touchIDNotEnrolled.rawValue:
                    message = "TouchID is not enrolled on the device"
                
                default:
                    message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"

        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
}
*/
