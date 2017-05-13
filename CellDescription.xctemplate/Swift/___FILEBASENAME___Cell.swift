//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit

class KGCD___FILEBASENAMEASIDENTIFIER___: KGCellDescription {

    override class var nibName:         String  {return "___FILEBASENAMEASIDENTIFIER___Cell"}
    override class var reuseIdentifier: String  {return "___FILEBASENAMEASIDENTIFIER___Cell"}
    override       var height:          CGFloat {return 44.0}
    
    public init(selectionType: KGCellSelectionType) {
        super.init(selectionType: .selectionType)
    }
    
    override func setUpCell(_ cell: UITableViewCell) {
        guard let cell = cell as? ___FILEBASENAMEASIDENTIFIER___Cell else {return}
        
        //FIXME: Set Up Cell
    }
}

class ___FILEBASENAMEASIDENTIFIER___Cell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
}
