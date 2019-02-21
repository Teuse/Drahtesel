import UIKit
import ReSwift

class SelectionViewController: UIViewController
{
   private var state = SelectionState()
   
   @IBOutlet private weak var copyButton: UIBarButtonItem!
   @IBOutlet private weak var topBar: UINavigationBar!
   @IBOutlet private weak var naviItem: UINavigationItem!
   @IBOutlet private weak var tableView: UITableView!
   @IBOutlet private weak var noCollectionsLabel: UILabel!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      tableView.delegate = self
      tableView.dataSource = self
      
      subscribe(self) { subcription in
         subcription.select { state in state.selectionState }
      }
      
      dispatch(action: MainViewAction.OpenedPage(page: .selectionBrowser))
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   private func onAddRowClicked()
   {
      let addAction = CollectionAction.Add(name: "")
      
      let text = "Please enter the new name for the Collection:"
      var alertModel = AlertViewModel(headline: "Add New Collction", text: text)
      alertModel.textField = ""
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: addAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
   
   private func updateTitle()
   {
      let nrBikes = state.collections.count
      navigationItem.title = nrBikes == 1
      ? "Copy Bike"
      : "Copy \(nrBikes) Bikes"
   }

   @IBAction private func onCancelClicked()
   {
      dismiss(animated: false, completion: nil)
   }
   
   @IBAction private func onCopyClicked()
   {
      if let col = state.selected {
         dispatch(action: BikeAction.CopySelectionTo(collection: col))
      }
      dismiss(animated: false, completion: nil)
   }
}

// --------------------------------------------------------------------------------
//MARK: - TableView

extension SelectionViewController: UITableViewDelegate, UITableViewDataSource
{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      if indexPath.section == 0 {
         onAddRowClicked()
      } else {
         let col = state.collections[indexPath.row]
         dispatch(action: SelectionAction.Select(collection: col))
      }
      tableView.reloadData()
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath)
      cell.accessoryType = indexPath.section == 0 ? .none : .disclosureIndicator
      cell.selectionStyle = indexPath.section == 0 ? .none : .default
      cell.textLabel?.text = indexPath.section == 0
         ? "New Collection"
         : state.collections[indexPath.row].name
      
      if indexPath.section != 0, let col = state.selected {
         let idx = state.collections.firstIndex(of: col)
         let isSelected = idx == indexPath.row
         cell.backgroundColor = isSelected ? UIColor.appGray : UIColor.white
         cell.textLabel?.textColor = isSelected ? UIColor.appBlue : UIColor.black
      }
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 2
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return section == 0 ? 1 : state.collections.count
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SelectionViewController: StoreSubscriber
{
   func newState(state: SelectionState)
   {
      self.state = state
      
      copyButton.isEnabled = state.selected != nil
      tableView.reloadData()
      
      noCollectionsLabel.isHidden = !state.collections.isEmpty
      
      if let col = state.selected {
         let ip = indexPath(for: col)
         tableView.selectRow(at: ip, animated: false, scrollPosition: .none)
      }
      
      updateTitle()
   }
   
   private func indexPath(for collection: Collection) -> IndexPath
   {
      let row = state.collections.firstIndex(of: collection)
      assert(row != nil)
      return IndexPath(row: row!, section: 1)
   }
}
