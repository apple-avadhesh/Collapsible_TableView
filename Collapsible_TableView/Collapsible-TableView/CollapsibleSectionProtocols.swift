//
//  CollapsibleSectionProtocols.swift
//  Collapsible_TableView
//
//  Created by Avadhesh Sharma on 05/10/18.
//  Copyright © 2018 Avadhesh Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol CollapsibleSectionHeaderProtocol {
    
    func open(_ animated: Bool)
    func close(_ animated: Bool)
    
    var sectionTitleLabel: UILabel! { get }
    
    var tappableDelegate: CollapsibleSectionHeaderTappableProtocol! { get set }
    
    var tag: Int { get set }
}

protocol CollapsibleSectionHeaderTappableProtocol {
    
    func sectionTapped(view: CollapsibleSectionHeaderProtocol)
}

protocol SectionItemProtocol {
    
    var title: String { get }
    
    var isVisible: Bool { get set }
    
    var items: [Employee] { get set }
}
