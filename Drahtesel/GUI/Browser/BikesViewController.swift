import UIKit
import ReSwift

class BikesViewController: UIViewController
{
   private var state = BikeBrowserState()
   
   @IBOutlet private weak var tableView: UITableView!
   @IBOutlet private weak var toolbar: UIToolbar!
   @IBOutlet private weak var copyToButton: UIBarButtonItem!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      tableView.delegate = self
      tableView.dataSource = self
      
      subscribe(self) { subcription in
         subcription.select { state in state.bikeBrowserState }
      }
      
      dispatch(action: MainViewAction.OpenedPage(page: .bikeBrowser))
      dispatch(action: BikeBrowserAction.SetEdit(enabled: false))
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   @IBAction private func onPlusClicked(_ sender: UIBarButtonItem)
   {
      let addAction = BikeBrowserAction.Add()
      
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
      dispatch(action: BikeBrowserAction.SetEdit(enabled: edit))
   }
   
   private func toolbar(show: Bool, animated: Bool)
   {
      let dur = animated ? UI.animationDuration : 0.0
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
      let renameAction = BikeBrowserAction.Rename(bike: bike)
      
      let text = "Enter a new name for your Bike"
      var alertModel = AlertViewModel(headline: "Rename", text: text)
      alertModel.textField = bike.name
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: renameAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
   
   private func onDuplicateClicked(_ bike: Bike)
   {
      let duplicateAction = BikeBrowserAction.Duplicate(bike: bike)
      
      let text = "Enter a name for the duplicated Bike"
      var alertModel = AlertViewModel(headline: "Duplicate", text: text)
      alertModel.textField = bike.name
      alertModel.showTextField = true
      alertModel.leftButton(type: .cancel)
      alertModel.rightButton(type: .ok, action: duplicateAction)
      
      dispatch(action: MainViewAction.PresentAlert(model: alertModel))
   }
   
   private func onDeleteClicked(_ bike: Bike)
   {
      let deleteAction = BikeBrowserAction.Delete(bike: bike)
      
      let text = "Do you really want to delete the Bike: \(bike.name)?"
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
      
      if state.isEditing {
         dispatch(action: BikeBrowserAction.Select(bike: bike))
      }
      else {
         dispatch(action: BikeBrowserAction.OpenBike(bike: bike))
         let vc: SetupRootViewController = Storyboard.create(name: UI.Storyboard.bikeSetup)
         show(vc, sender: nil)
      }
   }
   
   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
   {
      if state.isEditing {
         let bike = state.bikes[indexPath.row]
         dispatch(action: BikeBrowserAction.Deselect(bike: bike))
      }
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "BikeCell", for: indexPath)
      guard let bikeCell = cell as? BikeCell else {
         assertionFailure("Unable to dequeue BikeCell")
         return cell
      }
      bikeCell.bike = state.bikes[indexPath.row]
      return bikeCell
   }
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "BikeCellHeader")
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return state.bikes.count
   }
   
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
   {
      guard let col = state.collection, col.type != .factory else {
         return []
      }
      
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
   func newState(state: BikeBrowserState)
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
      
      copyToButton.isEnabled = state.isCopyButtonEnabled
   }
}
