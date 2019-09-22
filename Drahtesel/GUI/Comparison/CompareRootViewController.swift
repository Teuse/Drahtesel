import UIKit
import ReSwift

enum ComparisonViewTypes
{
   case geoComapre
   case specComapre
}

class CompareRootViewController: UIViewController
{
   var viewType: ComparisonViewTypes = .geoComapre
   
   private var isFirstViewShown = false
   private var geoController: CompareGeometryViewController = Storyboard.create(name: UI.Storyboard.compareGeometry)
   private var specController: CompareSpecificationViewController = Storyboard.create(name: UI.Storyboard.compareSpecification)
   
   @IBOutlet private weak var geoContainer: UIView!
   @IBOutlet private weak var specContainer: UIView!
   @IBOutlet private weak var closeButton: UIButton!
   @IBOutlet private weak var nextButton: UIButton!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      embed(geoController, in: geoContainer)
      embed(specController, in: specContainer)
      
      let radius = closeButton.frame.width / 2
      closeButton.layer.cornerRadius = radius
      nextButton.layer.cornerRadius = radius
      view.bringSubviewToFront(closeButton)
      view.bringSubviewToFront(nextButton)
      
      subscribe(self)
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
      showGeoCompareView(animate: false)
   }
   
   
   @IBAction private func onCloseClicked(_ sender: UIButton)
   {
      dismiss(animated: true, completion: nil)
   }
   
   @IBAction private func onNextClicked(_ sender: UIButton)
   {
      switch viewType {
      case .geoComapre:    showSpecCompareView()
      case .specComapre:   showGeoCompareView()
      }
   }
   
   private func showGeoCompareView(animate: Bool = true)
   {
      viewType = .geoComapre
      nextButton.setTitle(">", for: .normal)
      
//      geoController.view.translatesAutoresizingMaskIntoConstraints = true
      geoController.embeddedViewWillShow(true)
      geoContainer.frame.origin.x = -self.view.frame.width
      geoContainer.isHidden = false
      
      let doShow = {
         self.geoContainer.frame.origin.x = 0
         self.specContainer.frame.origin.x = self.view.frame.width
      }
      
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur, animations: doShow) { _ in
         self.specController.embeddedViewWillHide(true)
         self.specContainer.isHidden = true
      }
   }
   
   private func showSpecCompareView(animate: Bool = true)
   {
      viewType = .specComapre
      nextButton.setTitle("<", for: .normal)
      
//      specController.view.translatesAutoresizingMaskIntoConstraints = true
      specController.embeddedViewWillShow(true)
      specContainer.frame.origin.x = self.view.frame.width
      specContainer.isHidden = false
      
      let doShow = {
         self.geoContainer.frame.origin.x = -self.view.frame.width
         self.specContainer.frame.origin.x = 0.0
      }
      
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur, animations: doShow) { _ in
         self.geoController.embeddedViewWillHide(true)
         self.geoContainer.isHidden = true
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension CompareRootViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
