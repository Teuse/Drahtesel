import UIKit
import ReSwift

enum BikeSetupViewTypes
{
   case basics
   case geometry
   case specification
}

class SetupRootViewController: UIViewController
{
   var viewType: BikeSetupViewTypes = .basics
   
   @IBOutlet private weak var basicContainer: UIView!
   @IBOutlet private weak var geoContainer: UIView!
   @IBOutlet private weak var specContainer: UIView!
   @IBOutlet private weak var prevButton: UIButton!
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
      
      let radius = nextButton.frame.width / 2
      prevButton.layer.cornerRadius = radius
      nextButton.layer.cornerRadius = radius

      basicContainer.frame = view.frame
      geoContainer.frame = view.frame
      specContainer.frame = view.frame

      showBasicView(animate: false)
   }
   
   
   @IBAction private func onPrevClicked(_ sender: UIButton)
   {
      switch viewType {
      case .basics:        break
      case .geometry:      showBasicView()
      case .specification: showGeometryView()
      }
   }
   
   @IBAction private func onNextClicked(_ sender: UIButton)
   {
      switch viewType {
      case .basics:        showGeometryView()
      case .geometry:      showSpecificaionView()
      case .specification: break
      }
   }
   
   private func showBasicView(animate: Bool = true)
   {
      viewType = .basics
      let dur = animate ? 0.5 : 0.0
      UIView.animate(withDuration: dur) {
         self.basicContainer.frame.origin.x = 0
         self.geoContainer.frame.origin.x = self.view.frame.width
         self.specContainer.frame.origin.x = 2 * self.view.frame.width
      }
   }
   
   private func showGeometryView(animate: Bool = true)
   {
      viewType = .geometry
      let dur = animate ? 0.5 : 0.0
      UIView.animate(withDuration: dur) {
         self.basicContainer.frame.origin.x = -self.view.frame.width
         self.geoContainer.frame.origin.x = 0
         self.specContainer.frame.origin.x = self.view.frame.width
      }
   }
   
   private func showSpecificaionView(animate: Bool = true)
   {
      viewType = .specification
      let dur = animate ? 0.5 : 0.0
      UIView.animate(withDuration: dur) {
         self.basicContainer.frame.origin.x = -2 * self.view.frame.width
         self.geoContainer.frame.origin.x = -self.view.frame.width
         self.specContainer.frame.origin.x = 0
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupRootViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}
