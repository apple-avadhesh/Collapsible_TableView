//
//  ViewController.swift
//  Collapsible_TableView
//
//  Created by Avadhesh Sharma on 05/10/18.
//  Copyright © 2018 Avadhesh Sharma. All rights reserved.
//

import UIKit

class ViewController: CollapsibleTableVC {
    
    var menu = [SectionItemProtocol]()

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = ModelBuilder.modelGenerator()
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    //MARK: -
    //MARK: Protocol Conformance
    
    override func model() -> [SectionItemProtocol]? {
        return menu
    }
    
    override func sectionHeaderNibName() -> String? {
        return "SectionHeaderView"
    }
    
    override func singleOpenSelectionOnly() -> Bool {
        return true
    }
    
    override func collapsibleTableView() -> UITableView? {
        return tableView
    }
}

extension ViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}
