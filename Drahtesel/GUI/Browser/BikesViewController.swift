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
      dispatch(action: AppAction.OpenedPage(page: .bikeBrowser))
      
      tableView.delegate = self
      tableView.dataSource = self
      title = state.pageTitle
      
      subscribe(self) { subcription in
         subcription.select { state in state.bikesState }
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
      let bike = state.bikes[indexPath.row]
      cell.textLabel?.text = bike.name ?? "(nil)"
      cell.detailTextLabel?.text = bike.brand ?? "(nil)"
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return state.bikes.count
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
      
      if state.isEditing != tableView.isEditing {
         tableView.setEditing(state.isEditing, animated: true)
         toolbar(show: state.isEditing, animated: true)
      }
   }
}
