import UIKit
import ReSwift

class SetupGeometryViewController: UIViewController
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

extension SetupGeometryViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
