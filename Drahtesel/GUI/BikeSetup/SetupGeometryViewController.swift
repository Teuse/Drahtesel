import UIKit
import ReSwift

class SetupGeometryViewController: UIViewController, SetupController
{
   private let propertiesViewController: PropertiesViewController = Storyboard.create(name: UI.Storyboard.properties)
   
   @IBOutlet private weak var propertiesContainer: UIView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      propertiesViewController.useSmallCells = true
      propertiesViewController.isScrollEnabled = true
      propertiesViewController.showLetters = true
      embed(propertiesViewController, in: propertiesContainer)
   }
   
   func setupViewWillShow(_ animated: Bool)
   {
      subscribe(self) { subcription in
         subcription.select { state in state.setupGeometryState }
      }
      dispatch(action: MainViewAction.OpenedPage(page: .setupGeometry))
   }
   
   func setupViewWillHide(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupGeometryViewController: StoreSubscriber
{
   func newState(state: SetupGeometryState)
   {
      propertiesViewController.properties = state.model
   }
}
