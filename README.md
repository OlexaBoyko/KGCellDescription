# KGCellDescription
//Classes for managing UITableView in iOS

//In UITableViewController class add field tableSource:

var tableSource = KGTableViewSource()

//In viewDidLoad setUp tableSource:

override func viewDidLoad() {
  super.viewDidLoad()
  
  //Inherit KGCellDescription and make cellDescription instance of your class
  let cellDescription = KGCellDescription()
  
  tableSource.addSection(cellDescriptionArray: [cellDescription])
  
  //Set tableView for tableSource
  tableSource.tableView = self.tableView
}

//override method heightForRowAt: 

override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return tableSource.heightForRow(at: indexPath)
}
