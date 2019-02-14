import UIKit
import ReSwift

class SetupSpecificationViewController: UIViewController
{
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: MainViewAction.OpenedPage(page: .setupBasics))
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

extension SetupSpecificationViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
