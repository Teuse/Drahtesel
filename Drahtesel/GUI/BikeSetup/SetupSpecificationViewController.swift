import UIKit
import ReSwift

class SetupSpecificationViewController: UIViewController, EmbeddedController
{
   private let propertiesViewController1: PropertiesViewController = Storyboard.create(name: UI.Storyboard.properties)
   private let propertiesViewController2: PropertiesViewController = Storyboard.create(name: UI.Storyboard.properties)
   private let propertiesViewController3: PropertiesViewController = Storyboard.create(name: UI.Storyboard.properties)
   
   @IBOutlet private weak var stackView: UIStackView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      stackView.addArrangedSubview(propertiesViewController1.view)
      stackView.addArrangedSubview(propertiesViewController2.view)
      stackView.addArrangedSubview(propertiesViewController3.view)
   }
   
   func embeddedViewWillShow(_ animated: Bool)
   {
      subscribe(self) { subcription in
         subcription.select { state in state.setupSpecificationState }
      }
      dispatch(action: MainViewAction.OpenedPage(page: .setupSpecification))
   }
   
   func embeddedViewWillHide(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupSpecificationViewController: StoreSubscriber
{
   func newState(state: SetupSpecificationState)
   {
      propertiesViewController1.properties = state.model1
      propertiesViewController2.properties = state.model2
      propertiesViewController3.properties = state.model3
   }
}
