import UIKit
import ReSwift

class SetupRootViewController: UIViewController
{
   private struct SetupPage {
      let page: Page
      let container: UIView
      let controller: EmbeddedController
   }
   
   private var isFirstViewShown = false
   private var state = BikeSetupState()
   private var currentPage: SetupPage? = nil
   
   private var basicPage: SetupPage! = nil
   private var compPage: SetupPage! = nil
   private var geoPage: SetupPage! = nil
   private var specPage: SetupPage! = nil
   
   private var basicController: SetupBasicsViewController = Storyboard.create(name: UI.Storyboard.setupBasics)
   private var compController: SetupComparisonViewController = Storyboard.create(name: UI.Storyboard.setupComparison)
   private var geoController: SetupGeometryViewController = Storyboard.create(name: UI.Storyboard.setupGeometry)
   private var specController: SetupSpecificationViewController = Storyboard.create(name: UI.Storyboard.setupSpecification)
   
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
   
      basicContainer.isHidden = true
      compContainer.isHidden = true
      geoContainer.isHidden = true
      specContainer.isHidden = true
      
      embed(basicController, in: basicContainer)
      embed(compController, in: compContainer)
      embed(geoController, in: geoContainer)
      embed(specController, in: specContainer)
      
      basicPage = SetupPage(page: .setupBasics, container: basicContainer, controller: basicController)
      compPage = SetupPage(page: .setupComparison, container: compContainer, controller: compController)
      geoPage = SetupPage(page: .setupGeometry, container: geoContainer, controller: geoController)
      specPage = SetupPage(page: .setupSpecification, container: specContainer, controller: specController)
      
      subscribe(self){ subcription in
         subcription.select { state in state.bikeSetupState }
      }
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
      isFirstViewShown = false
   }
   
   override func viewDidLayoutSubviews()
   {
      super.viewDidLayoutSubviews()
      guard !isFirstViewShown else { return }
      
      isFirstViewShown = true
      switch state.lastSetupPage {
      case .setupBasics:         show(setupPage: basicPage, swipeLeft: false, animated: false)
      case .setupComparison:     show(setupPage: compPage, swipeLeft: false, animated: false)
      case .setupGeometry:       show(setupPage: geoPage, swipeLeft: false, animated: false)
      case .setupSpecification:  show(setupPage: specPage, swipeLeft: false, animated: false)
      default: assertionFailure("SetupRootViewControllerLast->viewDidLayoutSubviews: Last selected setupPage is not a setupPage?!?")
      }
   }
   
   @IBAction private func onPrevClicked(_ sender: UIButton)
   {
      guard let page = currentPage?.page else { return }
      
      switch page {
      case .setupBasics:        break
      case .setupComparison:    show(setupPage: basicPage, swipeLeft: false, animated: true)
      case .setupGeometry:      show(setupPage: compPage, swipeLeft: false, animated: true)
      case .setupSpecification: show(setupPage: geoPage, swipeLeft: false, animated: true)
      default: assertionFailure()
      }
   }
   
   @IBAction private func onNextClicked(_ sender: UIButton)
   {
      guard let page = currentPage?.page else { return }
      
      switch page {
      case .setupBasics:        show(setupPage: compPage, swipeLeft: true, animated: true)
      case .setupComparison:    show(setupPage: geoPage, swipeLeft: true, animated: true)
      case .setupGeometry:      show(setupPage: specPage, swipeLeft: true, animated: true)
      case .setupSpecification: break
      default: assertionFailure()
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - Show/Hide logic

extension SetupRootViewController
{
   private func show(setupPage: SetupPage, swipeLeft: Bool, animated: Bool)
   {
      let prevPage = currentPage
      currentPage = setupPage
      
      setupPage.controller.embeddedViewWillShow(animated)
      setupPage.container.frame.origin.x = swipeLeft ? view.frame.width : -view.frame.width
      setupPage.container.isHidden = false
      
      let doShow = {
         prevPage?.container.frame.origin.x = swipeLeft ? -self.view.frame.width : self.view.frame.width
         setupPage.container.frame.origin.x = 0
      }
      
      let dur = animated ? UI.animationDuration : 0
      UIView.animate(withDuration: dur, animations: doShow) { _ in
         self.hide(setupPage: prevPage)
      }
   }
   
   private func hide(setupPage: SetupPage?)
   {
      guard let setupPage = setupPage else { return }
      setupPage.controller.embeddedViewWillHide(false)
      setupPage.container.isHidden = true
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
