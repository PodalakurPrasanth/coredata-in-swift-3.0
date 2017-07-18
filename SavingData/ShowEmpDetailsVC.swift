//
//  ShowEmpDetailsVC.swift
//  SavingData
//
//  Created by prasanth.podalakur on 2/1/17.
//  Copyright © 2017 KelltonTech. All rights reserved.
//

import UIKit
import CoreData

class ShowEmpDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var showEmpDetailsTableView: UITableView!
    var empArray:[EmployeeDetails] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.showEmpDetailsTableView.register(UINib(nibName: "ShowEmpDertailsTVC", bundle: nil), forCellReuseIdentifier: "ShowEmpDertailsTVC")
        let emp:NSFetchRequest<EmployeeDetails> = EmployeeDetails.fetchRequest()
        do{
            self.empArray = try DataBaseController.persistentContainer.viewContext.fetch(emp)
            
        } catch{
            print(error.localizedDescription)
        }
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.showEmpDetailsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return empArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      let cell = self.showEmpDetailsTableView.dequeueReusableCell(withIdentifier: "ShowEmpDertailsTVC") as! ShowEmpDertailsTVC
        cell.cellSubView.layer.cornerRadius = 6
        let eachEMP = empArray[indexPath.row]
        cell.fullNameLabel.text! = eachEMP.fullName!
        cell.empIDLabel.text! = "\(eachEMP.empID)"
        cell.companyNameLabel.text! = eachEMP.company!
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updatedVC = UpdatedDataBaseVC(nibName: "UpdatedDataBaseVC", bundle: nil)
        updatedVC.employee = empArray[indexPath.row]
        self.present(updatedVC, animated: true, completion: nil)
    }
    

}
