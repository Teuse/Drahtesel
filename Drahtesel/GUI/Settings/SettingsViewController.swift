import UIKit
import ReSwift

class SettingsViewController: UIViewController
{

   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: MainViewAction.OpenedPage(page: .settings))
      subscribe(self)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   //MARK: - Actions
   
   @IBAction private func onCloseClicked(_ sender: UIButton)
   {
      dismiss(animated: true, completion: nil)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SettingsViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
