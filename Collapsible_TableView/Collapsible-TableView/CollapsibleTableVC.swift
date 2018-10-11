//
//  CollapsibleTableVC.swift
//  Collapsible_TableView
//
//  Created by Avadhesh Sharma on 05/10/18.
//  Copyright © 2018 Avadhesh Sharma. All rights reserved.
//

import UIKit

class CollapsibleTableVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let
            tableView = self.collapsibleTableView(),
            let nibName = self.sectionHeaderNibName(),
            let reuseID = self.sectionHeaderReuseIdentifier()
        {
            let nib = UINib(nibName: nibName, bundle: nil)
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseID)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func collapsibleTableView() -> UITableView? {
        return nil
    }
    
    func model() -> [SectionItemProtocol]? {
        return nil
    }
    
    func singleOpenSelectionOnly() -> Bool {
        return false
    }
    
    func sectionHeaderNibName() -> String? {
        return nil
    }
    
    func sectionHeaderReuseIdentifier() -> String? {
        return self.sectionHeaderNibName()
    }
}

extension CollapsibleTableVC : CollapsibleSectionHeaderTappableProtocol {
    
    func sectionTapped(view: CollapsibleSectionHeaderProtocol) {
        
        if let tableView = self.collapsibleTableView() {
            
            let section = view.tag
            
            tableView.beginUpdates()
            
            var foundOpenUnchosenMenuSection = false
            
            let menu = self.model()
            
            if let menu = menu {
                
                var count = 0
                
                for var menuSection in menu {
                    
                    let chosenMenuSection = (section == count)
                    
                    let isVisible = menuSection.isVisible
                    
                    if isVisible && chosenMenuSection {
                        
                        menuSection.isVisible = false
                        
                        view.close(true)
                        
                        let indexPaths = self.indexPaths(section: section, menuSection: menuSection)
                        
                        tableView.deleteRows(at: indexPaths as [IndexPath], with: (foundOpenUnchosenMenuSection) ? .bottom : .top)
                        
                    } else if !isVisible && chosenMenuSection {
                        
                        menuSection.isVisible = true
                        
                        view.open(true)
                        
                        let indexPaths = self.indexPaths(section: section, menuSection: menuSection)
                        
                        tableView.insertRows(at: indexPaths as [IndexPath], with: (foundOpenUnchosenMenuSection) ? .bottom : .top)
                        
                    } else if isVisible && !chosenMenuSection && self.singleOpenSelectionOnly() {
                        
                        foundOpenUnchosenMenuSection = true
                        
                        menuSection.isVisible = false
                        
                        let headerView = tableView.headerView(forSection: count)
                        
                        if let headerView = headerView as? CollapsibleSectionHeaderProtocol {
                            headerView.close(true)
                        }
                        
                        let indexPaths = self.indexPaths(section: count, menuSection: menuSection)
                        
                        tableView.deleteRows(at: indexPaths as [IndexPath], with: (view.tag > count) ? .top : .bottom)
                    }
                    
                    count += 1
                }
            }
            tableView.endUpdates()
        }
    }
    
    func indexPaths(section: Int, menuSection: SectionItemProtocol) -> [NSIndexPath] {
        var collector = [NSIndexPath]()
        
        var indexPath: NSIndexPath
        for i in 0 ..< menuSection.items.count {
            indexPath = NSIndexPath(row: i, section: section)
            collector.append(indexPath)
        }
        return collector
    }
}

extension CollapsibleTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? CollapsibleSectionHeaderProtocol {
                        let menuSection = self.model()?[section]
                        if (menuSection?.isVisible ?? false) {
                            view.open(false)
                        } else {
                            view.close(false)
                        }
                    }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view: CollapsibleSectionHeaderProtocol?
        
        if let reuseID = self.sectionHeaderReuseIdentifier() {
            view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseID) as? CollapsibleSectionHeaderProtocol
        }
        
        view?.tag = section
        
        let menuSection = self.model()?[section]
        view?.sectionTitleLabel.text = (menuSection?.title ?? "")
        view?.sectionTitleLabel.textColor = .green
        view?.tappableDelegate = self
        
        return view as? UIView
    }
}


extension CollapsibleTableVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.model() ?? []).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuSection = self.model()?[section]
        return (menuSection?.isVisible ?? false) ? menuSection!.items.count : 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
       
        let menuSection = self.model()?[ indexPath.section]
        cell.name.text = menuSection?.items[indexPath.row].name
        
        return cell
    }
}
