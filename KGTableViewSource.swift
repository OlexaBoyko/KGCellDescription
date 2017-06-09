//
//  KGTableViewSource.swift
//
//
//  Created by Olexa Boyko on 5/11/17.
//  Copyright © 2017 Olexa Boyko. All rights reserved.
//

import Foundation

class KGTableViewSource: NSObject {
    fileprivate var sections: Int {
        get {
            return cellDescriptionArray.count
        }
    }
    public weak var tableView: UITableView? {
        didSet {
            self.tableView?.dataSource = self
            self.registerCells()
        }
    }
    fileprivate var cellDescriptionArray: [[KGCellDescription]] = []
    
    public func clearTable() {
        self.cellDescriptionArray = []
    }
    
    public func addSection(cellDescriptionArray: [KGCellDescription]) {
        for value in cellDescriptionArray {
            value.cellReloader = self
        }
        
        self.cellDescriptionArray.append(cellDescriptionArray)
    }
    
    public func indexPathFor(_ cellDescription: KGCellDescription) -> IndexPath? {
        
        for i in 0..<self.cellDescriptionArray.count {
            for j in 0..<self.cellDescriptionArray[i].count {
                if self.cellDescriptionArray[i][j] === cellDescription {
                    return IndexPath.init(row: j, section: i)
                }
            }
        }
        
        return nil
    }
    
    public func cellDescription(at: IndexPath) -> KGCellDescription {
        return self.cellDescriptionArray[at.section][at.row]
    }
    
    public func modifyKGCellDescription(modifier: @escaping (KGCellDescription) -> Void) {
        for section in self.cellDescriptionArray {
            _ = section.map({modifier($0)})
        }
    }
    
    public func heightForRow(at: IndexPath) -> CGFloat {
        return cellDescription(at: at).height
    }
    
    private func registerCells() {
        
        guard let tableView = self.tableView else {
            fatalError("Assign tableView to source.tableView")
        }
        
        var set = Set<String>()
        
        for section in self.cellDescriptionArray {
            for row in section {
                if (set.insert(row.reuseIdentifier)).inserted {
                    type(of: row).registerCell(for: tableView)
                }
            }
        }
    }
    
    public func didSelectRow(
        cellDescription: KGCellDescription,
        selectedRow: ((KGCellDescription) -> Void)? = nil,
        otherRows: ((KGCellDescription) -> Void)? = nil) {
        
        for section in self.cellDescriptionArray {
            for row in section {
                
                if row === cellDescription {
                    selectedRow?(row)
                } else {
                    otherRows?(row)
                }
                
            }
        }
        
        self.tableView?.reloadData()
        
    }
    
    public func didSelectRowAt(
        indexPath: IndexPath,
        selectedRow: ((KGCellDescription) -> Void)? = nil,
        otherRows: ((KGCellDescription) -> Void)? = nil) {
        for sectionIndex in 0..<self.cellDescriptionArray.count {
            for rowIndex in 0..<sectionIndex {
                guard sectionIndex != indexPath.section,
                    rowIndex != indexPath.row else {
                        selectedRow?(self.cellDescriptionArray[sectionIndex][rowIndex])
                        continue
                }
                
                otherRows?(self.cellDescriptionArray[sectionIndex][rowIndex])
                
            }
        }
        
        self.tableView?.reloadData()
    }
    
    public subscript(index: Int) -> [KGCellDescription] {
        get {
            return self.cellDescriptionArray[index]
        }
        
        set(value) {
            self.cellDescriptionArray[index] = value
        }
    }
    
    public subscript(indexPath: IndexPath) -> KGCellDescription {
        get {
            return self.cellDescription(at: indexPath)
        }
        
        set(value) {
            self.cellDescriptionArray[indexPath.section][indexPath.row] = value
        }
    }
}

extension KGTableViewSource: KGCellReloader {
    func reloadCell(cellDescription: KGCellDescription, animation: UITableViewRowAnimation = .right) {
        
        guard let indexPath = indexPathFor(cellDescription) else {
            return
        }
        
        self.tableView?.reloadRows(at: [indexPath], with: animation)
    }
}

extension KGTableViewSource: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellDescriptionArray[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cellDescriptionArray[indexPath.section][indexPath.row].instantiateCell(for: tableView)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.cellDescriptionArray.count
    }
}
