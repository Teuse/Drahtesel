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
   
   @IBOutlet private weak var geoContainer: UIView!
   @IBOutlet private weak var specContainer: UIView!
   @IBOutlet private weak var closeButton: UIButton!
   @IBOutlet private weak var nextButton: UIButton!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      let radius = closeButton.frame.width / 2
      closeButton.layer.cornerRadius = radius
      nextButton.layer.cornerRadius = radius

      geoContainer.frame = view.frame
      specContainer.frame = view.frame
      
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
      
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur) {
         self.geoContainer.frame.origin.x = 0
         self.specContainer.frame.origin.x = self.view.frame.width
      }
   }
   
   private func showSpecCompareView(animate: Bool = true)
   {
      viewType = .specComapre
      nextButton.setTitle("<", for: .normal)
      
      let dur = animate ? UI.animationDuration : 0.0
      UIView.animate(withDuration: dur) {
         self.geoContainer.frame.origin.x = -self.view.frame.width
         self.specContainer.frame.origin.x = 0.0
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
