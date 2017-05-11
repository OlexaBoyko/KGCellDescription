//
//  KGCellDescription.swift
//  
//
//  Created by Olexa Boyko on 5/11/17.
//  Copyright © 2017 Olexa Boyko. All rights reserved.
//

import Foundation

public protocol KGCellReloader {
    func reloadCell(cellDescription: KGCellDescription, animation: UITableViewRowAnimation)
}

public class KGCellDescription {
    
    public var cellReloader: KGCellReloader?
    
    //MARK: variables
    
    ///Describes if cell can be selected and perform some action
    public final var selectionType: KGCellSelectionType = .none
    
    ///name of .xib file containing cell. Requires to be overriden!
    class var nibName: String {
        return ""
    }
    
    ///Cell reuseIdentifier. Requires to be overriden!
    class var reuseIdentifier: String {
        return ""
    }
    
    ///Needed for using in son's instances
    internal final var reuseIdentifier: String {
        
        return type(of: self).reuseIdentifier
    }
    
    ///Height of cell for tableView's method heightForRowAt. Optional overriding.
    public var height: CGFloat {
        return 76.0
    }
    
    //MARK: initializers
    
    internal init(selectionType: KGCellSelectionType) {
        self.selectionType = selectionType
    }
    
    //MARK: methods
    
    ///Requires to be called in viewDidLoad method by every CellDescription class you use!
    class public final func registerCell(for tableView: UITableView) {
        tableView.register(UINib(nibName: self.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: self.reuseIdentifier)
    }
    
    ///Required to be overriden! Setts up cell due to CellDescription instance
    internal func setUpCell(_ cell: UITableViewCell) {}
    
    public final func instantiateCell(for tableView: UITableView) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseIdentifier) else {
            fatalError("Trying instantiate not registered cell")
        }
        
        //self.setUpCell(cell)
        
        switch self.selectionType {
        case .none:
            cell.selectionStyle = .none
            cell.accessoryType = .none
        case .classic:
            cell.selectionStyle = .default
            cell.accessoryType = .disclosureIndicator
        case .expandable:
            cell.selectionStyle = .none
            cell.accessoryType = .none
        }
        
        self.setUpCell(cell)
        return cell
    }
}

public enum KGCellSelectionType {
    case none, classic, expandable
}
