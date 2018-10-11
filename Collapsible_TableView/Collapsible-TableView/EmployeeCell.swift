//
//  EmployeeCell.swift
//  Collapsible_TableView
//
//  Created by Avadhesh Sharma on 06/10/18.
//  Copyright © 2018 Avadhesh Sharma. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(employee :Employee ,indexPath:NSIndexPath)
    {
        self.name.text = employee.name
    }
}
