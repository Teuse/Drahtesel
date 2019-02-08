import UIKit
import ReSwift

class MainViewController: UIViewController
{
   var isButtonHidden = true
   var isButtonLarge = false
   
   @IBOutlet private weak var compareButton: UIButton!
   @IBOutlet private weak var buttonContainerLarge: UIView!
   @IBOutlet private weak var buttonContainerSmall: UIView!
   @IBOutlet private weak var navigationContainer: UIView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      compareButton.translatesAutoresizingMaskIntoConstraints = true
      subscribe(self)
   }
   
   override func viewDidLayoutSubviews()
   {
      button(show: !isButtonHidden, animated: false)
      button(large: isButtonLarge, animated: false)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
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
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension MainViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
      if isButtonHidden != state.buttonHidden {
         isButtonHidden = state.buttonHidden
         button(show: !state.buttonHidden, animated: true)
      }
      
      if isButtonLarge != state.buttonLarge {
         isButtonLarge = state.buttonLarge
         button(large: state.buttonLarge, animated: true)
      }
   }
}
