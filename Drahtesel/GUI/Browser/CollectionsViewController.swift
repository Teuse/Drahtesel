import UIKit
import ReSwift

class CollectionsViewController: UIViewController
{
   private var state = CollectionsState()
   
   @IBOutlet private weak var tableView: UITableView!
   
   //MARK: - Life Circle
   // -----------------------------------------------------------------------------
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: MainViewAction.OpenedPage(page: .collectionBrowser))
      
      tableView.delegate = self
      tableView.dataSource = self
      
      subscribe(self) { subcription in
         subcription.select { state in state.collectionsState }
      }
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   //MARK: - Actions
   // -----------------------------------------------------------------------------
   
   @IBAction private func onPlusClicked(_ sender: UIBarButtonItem)
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
   
   private func onRenameClicked(_ collection: Collection)
   {
      let renameAction = CollectionAction.Rename(collection: collection, name: "")
      
      let text = "Enter a new name for your Collection"
      var alertModel = AlertViewModel(headline: "Rename", text: text)
      alertModel.textField = collection.name ?? ""
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: renameAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
   
   private func onDuplicateClicked(_ collection: Collection)
   {
      let duplicateAction = CollectionAction.Duplicate(collection: collection, name: "")
      
      let text = "Enter a name for the duplicated Collection"
      var alertModel = AlertViewModel(headline: "Duplicate", text: text)
      alertModel.textField = collection.name ?? ""
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: duplicateAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
   
   private func onDeleteClicked(_ collection: Collection)
   {
      let deleteAction = CollectionAction.Delete(collection: collection)
      
      let text = "Do you really want to delete the Collection: \(collection.name ?? String())?"
      var alertModel = AlertViewModel(headline: "Delete", text: text)
      alertModel.showTextField = false
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .delete, action: deleteAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
}

// --------------------------------------------------------------------------------
//MARK: - TableView

extension CollectionsViewController: UITableViewDelegate, UITableViewDataSource
{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      let collection = state.collection(at: indexPath)
      dispatch(action: CollectionAction.Select(collection: collection))
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath)
      
      let collection = state.collection(at: indexPath)
      cell.textLabel?.text = collection.name
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return state.collectionTypes.count
   }
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      let type = state.collectionTypes[section]
      return type.description()
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let colls = state.collections(at: section)
      return colls.count
   }
   
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      let collection = state.collection(at: indexPath)
      let delete = UITableViewRowAction(style: .destructive, title: "Delete") {_,_ in
         self.onDeleteClicked(collection)
      }
      let duplicate = UITableViewRowAction(style: .normal, title: "Duplicate") {_,_ in
         self.onDuplicateClicked(collection)
      }
      duplicate.backgroundColor = UIColor.blue
      let rename = UITableViewRowAction(style: .normal, title: "Rename") {_,_ in
         self.onRenameClicked(collection)
      }
   
      let type = state.collectionTypes[indexPath.section]
      if type != .factory {
         return [delete, duplicate, rename]
      }
      return [duplicate]
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension CollectionsViewController: StoreSubscriber
{
   func newState(state: CollectionsState)
   {
      self.state = state
      
      if state.isDataUpdated {
         tableView.reloadData()
      }
      
      if state.isEditing != tableView.isEditing {
         tableView.setEditing(state.isEditing, animated: true)
      }
   }
}