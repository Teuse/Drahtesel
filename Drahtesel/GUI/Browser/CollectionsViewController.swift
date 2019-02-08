import UIKit
import ReSwift

class CollectionsViewController: UIViewController
{
   private var state = CollectionsState()
   
   @IBOutlet private weak var tableView: UITableView!
   @IBOutlet private weak var toolbar: UIToolbar!

   
   //MARK: - Life Circle
   // -----------------------------------------------------------------------------
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: AppAction.OpenedPage(page: .collectionBrowser))
      
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
   
   @IBAction private func onEditButton(_ sender: UIBarButtonItem)
   {
      let edit = !state.isEditing
      dispatch(action: CollectionAction.SetEdit(enabled: edit))
   }
   
   private func toolbar(show: Bool, animated: Bool)
   {
      let dur = animated ? 0.5 : 0.0
      UIView.animate(withDuration: dur) {
         let height = self.view.safeAreaLayoutGuide.layoutFrame.height
         let yPos = show
            ? height - self.toolbar.frame.height
            : self.view.frame.height
         self.toolbar.frame.origin.y = yPos
      }
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
         toolbar(show: state.isEditing, animated: true)
      }
   }
}
