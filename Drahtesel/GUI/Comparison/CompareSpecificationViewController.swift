import UIKit
import ReSwift

class CompareSpecificationViewController: UIViewController, EmbeddedController
{
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      dispatch(action: MainViewAction.OpenedPage(page: .compareSpecification))
      subscribe(self)
   }
   
   func embeddedViewWillShow(_ animated: Bool)
   {
      subscribe(self)
      dispatch(action: MainViewAction.OpenedPage(page: .compareSpecification))
   }
   
   func embeddedViewWillHide(_ animated: Bool) {
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
