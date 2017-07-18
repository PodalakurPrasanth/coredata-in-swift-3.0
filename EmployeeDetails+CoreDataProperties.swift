//
//  EmployeeDetails+CoreDataProperties.swift
//  SavingData
//
//  Created by prasanth.podalakur on 2/1/17.
//  Copyright © 2017 KelltonTech. All rights reserved.
//

import Foundation
import CoreData


extension EmployeeDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeDetails> {
        return NSFetchRequest<EmployeeDetails>(entityName: "EmployeeDetails");
    }

    @NSManaged public var fullName: String?
    @NSManaged public var empID: Int16
    @NSManaged public var company: String?

}
