import UIKit
import ReSwift

class MainViewController: UIViewController
{
   private var isButtonShown = false
   private var isButtonLarge = true
   
   private var alertViewController: AlertViewController? = nil
   
   @IBOutlet private weak var compareButton: UIButton!
   @IBOutlet private weak var buttonContainerLarge: UIView!
   @IBOutlet private weak var buttonContainerSmall: UIView!
   @IBOutlet private weak var navigationContainer: UIView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      compareButton.translatesAutoresizingMaskIntoConstraints = true
      subscribe(self) { subcription in
         subcription.select { state in state.mainViewState }
      }
   }
   
   override func viewDidLayoutSubviews()
   {
      button(show: isButtonShown, animated: false)
      button(large: isButtonLarge, animated: false)
   }
   
   deinit {
      unsubscribe(self)
   }
   
   private func button(show: Bool, animated: Bool)
   {
      let dur = animated ? 0.5 : 0.0
      UIView.animate(withDuration: dur) {
         self.compareButton.alpha = show ? 1.0 : 0.0
      }
   }
   
   private func button(large: Bool, animated: Bool)
   {
      let dur = animated ? 0.5 : 0.0
      UIView.animate(withDuration: dur) {
         let container = large ? self.buttonContainerLarge! : self.buttonContainerSmall!
         let size = container.frame.width
         self.compareButton.frame = container.frame
         self.compareButton.layer.cornerRadius = size / 2
      }
   }
   
   private func showAlert(model: AlertViewModel)
   {
      let sb = UIStoryboard(name: "Alert", bundle: nil)
      alertViewController = sb.instantiateInitialViewController() as? AlertViewController
      if let vc = alertViewController {
         vc.model = model
         vc.view.frame = view.frame
         view.addSubview(vc.view)
         addChild(vc)
      } else {
         alertViewController = nil
         assertionFailure("MainViewController->showAlert: Failed to open alertView")
      }
   }
   
   private func removeAlert()
   {
      alertViewController?.view.removeFromSuperview()
      alertViewController = nil
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension MainViewController: StoreSubscriber
{
   func newState(state: MainViewState)
   {
      if isButtonShown != state.buttonShown {
         isButtonShown = state.buttonShown
         button(show: isButtonShown, animated: true)
      }
      
      if isButtonLarge != state.buttonLarge {
         isButtonLarge = state.buttonLarge
         button(large: isButtonLarge, animated: true)
      }
      
      if alertViewController == nil, let model = state.alertViewModel {
         showAlert(model: model)
      } else if alertViewController != nil, state.alertViewModel == nil {
         removeAlert()
      }
   }
}
