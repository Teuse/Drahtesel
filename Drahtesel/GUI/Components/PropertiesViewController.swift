import UIKit
import ReSwift

// --------------------------------------------------------------------------------
//MARK: - Properties Model

struct PropertyModel {
   let name: String
   let label: String
   let action: TextSetableAction
}

// --------------------------------------------------------------------------------
//MARK: - PropertiesViewController

class PropertiesViewController: UIViewController
{
   var properties = [PropertyModel]() {
      didSet { tableView?.reloadData() }
   }
   
   var useSmallCells = false {
      didSet { setupTableView() }
   }
   
   var isScrollEnabled = true {
      didSet { setupTableView() }
   }
   
   var showLetters = false {
      didSet { setupTableView() }
   }
   
   private let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                          "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
   
   @IBOutlet weak var tableView: UITableView!
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      tableView.dataSource = self
      setupTableView()
   }
   
   private func setupTableView()
   {
      tableView?.rowHeight = useSmallCells ? 44 : 55
      tableView?.isScrollEnabled = isScrollEnabled
      tableView?.separatorInset.left = showLetters ? 34 : 15
   }
}

// --------------------------------------------------------------------------------
//MARK: - TableView

extension PropertiesViewController: UITableViewDataSource
{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return properties.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let reuseId = useSmallCells ? "PropertiesSmallCell" : "PropertiesCell"
      let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
      guard let propCell = cell as? PropertiesCell else {
         assertionFailure("Unable to dequeue BikeCell")
         return cell
      }
      propCell.property = properties[indexPath.row]
      if showLetters {
         propCell.letter = letters[indexPath.row]
      }
      return propCell
   }
}
