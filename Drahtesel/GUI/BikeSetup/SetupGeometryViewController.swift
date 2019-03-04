import UIKit
import ReSwift

class SetupGeometryViewController: UIViewController
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
      
      subscribe(self) { subcription in
         subcription.select { state in state.setupGeometryState }
      }
      dispatch(action: MainViewAction.OpenedPage(page: .setupGeometry))
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
   func newState(state: SetupGeometryState)
   {
      propertiesViewController.properties = state.geometryModel
   }
}
