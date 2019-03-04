import UIKit
import ReSwift

class SetupRootViewController: UIViewController
{
   private var state = BikeSetupState()
   private var page: Page = .setupBasics
   
   @IBOutlet private weak var basicContainer: UIView!
   @IBOutlet private weak var compContainer: UIView!
   @IBOutlet private weak var geoContainer: UIView!
   @IBOutlet private weak var specContainer: UIView!
   @IBOutlet private weak var prevButton: UIButton!
   @IBOutlet private weak var nextButton: UIButton!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      let radius = nextButton.frame.width / 2
      prevButton.layer.cornerRadius = radius
      nextButton.layer.cornerRadius = radius
      view.bringSubviewToFront(prevButton)
      view.bringSubviewToFront(nextButton)
      
      subscribe(self){ subcription in
         subcription.select { state in state.bikeSetupState }
      }
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   override func viewDidLayoutSubviews()
   {
      switch state.lastSetupPage {
      case .setupBasics: showBasicView(animate: false)
      case .setupGeometry: showGeometryView(animate: false)
      case .setupComparison: showComparissonView(animate: false)
      case .setupSpecification: showComparissonView(animate: false)
      default: assertionFailure("SetupRootViewControllerLast->viewDidLayoutSubviews: Last selected setupPage is not a setupPage?!?")
      }
   }
   
   @IBAction private func onPrevClicked(_ sender: UIButton)
   {
      switch page {
      case .setupBasics:        break
      case .setupComparison:    showBasicView()
      case .setupGeometry:      showComparissonView()
      case .setupSpecification: showGeometryView()
      default: assertionFailure()
      }
   }
   
   @IBAction private func onNextClicked(_ sender: UIButton)
   {
      switch page {
      case .setupBasics:        showComparissonView()
      case .setupComparison:    showGeometryView()
      case .setupGeometry:      showSpecificaionView()
      case .setupSpecification: break
      default: assertionFailure()
      }
   }
   
   private func showBasicView(animate: Bool = true)
   {
      page = .setupBasics
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur) {
         self.basicContainer.frame.origin.x = 0
         self.compContainer.frame.origin.x = self.view.frame.width
         self.geoContainer.frame.origin.x = 2 * self.view.frame.width
         self.specContainer.frame.origin.x = 3 * self.view.frame.width
      }
   }
   
   private func showComparissonView(animate: Bool = true)
   {
      page = .setupComparison
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur) {
         self.basicContainer.frame.origin.x = -self.view.frame.width
         self.compContainer.frame.origin.x = 0
         self.geoContainer.frame.origin.x = self.view.frame.width
         self.specContainer.frame.origin.x = 2 * self.view.frame.width
      }
   }
   
   private func showGeometryView(animate: Bool = true)
   {
      page = .setupGeometry
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur) {
         self.basicContainer.frame.origin.x = -2 * self.view.frame.width
         self.compContainer.frame.origin.x = -self.view.frame.width
         self.geoContainer.frame.origin.x = 0
         self.specContainer.frame.origin.x = self.view.frame.width
      }
   }
   
   private func showSpecificaionView(animate: Bool = true)
   {
      page = .setupSpecification
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur) {
         self.basicContainer.frame.origin.x = -3 * self.view.frame.width
         self.compContainer.frame.origin.x = -2 * self.view.frame.width
         self.geoContainer.frame.origin.x = -self.view.frame.width
         self.specContainer.frame.origin.x = 0
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupRootViewController: StoreSubscriber
{
   func newState(state: BikeSetupState)
   {
      self.state = state
   }
}
