import UIKit
import ReSwift

class CompareGeometryViewController: UIViewController
{
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: AppAction.OpenedPage(page: .compareGeometry))
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

extension CompareGeometryViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
