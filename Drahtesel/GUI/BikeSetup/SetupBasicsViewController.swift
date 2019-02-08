import UIKit
import ReSwift

class SetupBasicsViewController: UIViewController
{
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: AppAction.OpenedPage(page: .setupBasics))
      subscribe(self)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupBasicsViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
