import UIKit
import ReSwift

class BikesViewController: UIViewController
{
   private var state = BikesState()
   
   @IBOutlet private weak var tableView: UITableView!
   @IBOutlet private weak var toolbar: UIToolbar!
   
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: MainViewAction.OpenedPage(page: .bikeBrowser))
      
      tableView.delegate = self
      tableView.dataSource = self
      
      subscribe(self) { subcription in
         subcription.select { state in state.bikesState }
      }
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   @IBAction private func onPlusClicked(_ sender: UIBarButtonItem)
   {
      let addAction = BikeAction.Add(name: "")
      
      let text = "Please enter the name for the new Bike:"
      var alertModel = AlertViewModel(headline: "Add New Bike", text: text)
      alertModel.textField = ""
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: addAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
      
   @IBAction private func onEditButton(_ sender: UIBarButtonItem)
   {
      let edit = !state.isEditing
      dispatch(action: BikeAction.SetEdit(enabled: edit))
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
   
   private func onRenameClicked(_ bike: Bike)
   {
      let renameAction = BikeAction.Rename(bike: bike, name: "")
      
      let text = "Enter a new name for your Bike"
      var alertModel = AlertViewModel(headline: "Rename", text: text)
      alertModel.textField = bike.name ?? ""
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: renameAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
   
   private func onDuplicateClicked(_ bike: Bike)
   {
      let duplicateAction = BikeAction.Duplicate(bike: bike, name: "")
      
      let text = "Enter a name for the duplicated Bike"
      var alertModel = AlertViewModel(headline: "Duplicate", text: text)
      alertModel.textField = bike.name ?? ""
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: duplicateAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
   
   private func onDeleteClicked(_ bike: Bike)
   {
      let deleteAction = BikeAction.Delete(bike: bike)
      
      let text = "Do you really want to delete the Bike: \(bike.name ?? String())?"
      var alertModel = AlertViewModel(headline: "Delete", text: text)
      alertModel.showTextField = false
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .delete, action: deleteAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
}

// --------------------------------------------------------------------------------
//MARK: - TableView

extension BikesViewController: UITableViewDelegate, UITableViewDataSource
{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      let bike = state.bikes[indexPath.row]
      dispatch(action: BikeAction.Select(bike: bike))
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "BikeCell", for: indexPath)
      guard let bikeCell = cell as? BikeCell else {
         assertionFailure("Unable to dequeue BikeCell")
         return cell
      }
      let bike = state.bikes[indexPath.row]
      bikeCell.name = bike.name ?? "(nil)"
      bikeCell.brand = bike.brand ?? "(nil)"
      return bikeCell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return state.bikes.count
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return state.collection.type != .factory
   }
   
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
   {
      let bike = state.bikes[indexPath.row]
      let delete = UITableViewRowAction(style: .destructive, title: "Delete") {_,_ in
         self.onDeleteClicked(bike)
      }
      let duplicate = UITableViewRowAction(style: .normal, title: "Duplicate") {_,_ in
         self.onDuplicateClicked(bike)
      }
      duplicate.backgroundColor = UIColor.blue
      let rename = UITableViewRowAction(style: .normal, title: "Rename") {_,_ in
         self.onRenameClicked(bike)
      }
      return [delete, duplicate, rename]
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension BikesViewController: StoreSubscriber
{
   func newState(state: BikesState)
   {
      self.state = state
      
      if state.isDataUpdated {
         tableView.reloadData()
      }
      
      if title != state.pageTitle {
         title = state.pageTitle
      }
      
      if state.isEditing != tableView.isEditing {
         tableView.setEditing(state.isEditing, animated: true)
         toolbar(show: state.isEditing, animated: true)
      }
   }
}