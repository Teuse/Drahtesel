import UIKit
import ReSwift

class SelectionViewController: UIViewController
{
   private var state = SelectionState()
   
   @IBOutlet private weak var copyButton: UIBarButtonItem!
   @IBOutlet private weak var topBar: UINavigationBar!
   @IBOutlet private weak var tableView: UITableView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: MainViewAction.OpenedPage(page: .selectionBrowser))
      
      tableView.delegate = self
      tableView.dataSource = self
      
      subscribe(self) { subcription in
         subcription.select { state in state.selectionState }
      }
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
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath)
      cell.textLabel?.text = (indexPath.section == 0)
         ? "New Collection"
         : state.collections[indexPath.row].name
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
      
      if let col = state.selected {
         let ip = indexPath(for: col)
         tableView.selectRow(at: ip, animated: false, scrollPosition: .none)
      }
   }
   
   private func indexPath(for collection: Collection) -> IndexPath
   {
      let row = state.collections.firstIndex(of: collection)
      assert(row != nil)
      return IndexPath(row: row!, section: 1)
   }
}
