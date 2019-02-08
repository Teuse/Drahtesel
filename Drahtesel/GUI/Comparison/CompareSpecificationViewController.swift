import UIKit
import ReSwift

class CompareSpecificationViewController: UIViewController
{
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: AppAction.OpenedPage(page: .compareSpecification))
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

extension CompareSpecificationViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
