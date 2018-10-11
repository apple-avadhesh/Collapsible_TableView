//
//  ModelBuilder.swift
//  Collapsible_TableView
//
//  Created by Avadhesh Sharma on 05/10/18.
//  Copyright © 2018 Avadhesh Sharma. All rights reserved.
//

import UIKit

struct Employee {
    
    var name: String
    var department: Department
    
}

class TableSection: SectionItemProtocol {
    
    var title: String
    var isVisible: Bool
    var items: [Employee]
    
    init() {
        title = ""
        isVisible = false
        items = []
    }
}

enum Department: String {
    case android = "Android"
    case iOS = "iOS"
    case dotNet = ".Net"
    case reactNative = "React native"
}

class ModelBuilder: NSObject {
    
    class func modelGenerator() -> [SectionItemProtocol] {
        
        var collector = [SectionItemProtocol]()
        
        let employees = [Employee(name: "Vishal", department: .iOS),
                         Employee(name: "Avadhesh", department: .iOS),
                         Employee(name: "Kunal", department: .android),
                         Employee(name: "Jasvir", department: .android),
                         Employee(name: "Manjeet", department: .reactNative),
                         Employee(name: "Anuj", department: .reactNative),
                         Employee(name: "Tejender", department: .dotNet),
                         Employee(name: "Vishal Choudhary", department: .dotNet)]
        
        let uniqueDepartments = NSOrderedSet(array: employees.map{ $0.department.rawValue})

        
        for (_, department) in uniqueDepartments.enumerated() {
            
            let section = TableSection()
            section.title = department as! String
            
            for employee in employees {
                
                if employee.department.rawValue == department as! String {
                    section.items.append(employee)
                }
            }
            collector.append(section)
        }
        
        return collector
    }
}
