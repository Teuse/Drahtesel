import UIKit
import ReSwift

class AlertViewController: UIViewController
{
   var model = AlertViewModel(headline: "", text: "") {
      didSet { if isViewLoaded { updateView() } }
   }
   
   @IBOutlet private weak var alertView: UIView!
   @IBOutlet private weak var headline: UILabel!
   @IBOutlet private weak var text: UILabel!
   @IBOutlet private weak var errorText: UILabel!
   @IBOutlet private weak var textField: UITextField!
   @IBOutlet private weak var leftButton: UIButton!
   @IBOutlet private weak var rightButton: UIButton!
   
   //MARK: - Life Circle
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      textField.delegate = self
      textField.autocorrectionType = .no
      alertView.translatesAutoresizingMaskIntoConstraints = true
      alertView.center = view.center
      
      updateView()
   }

   private func updateView()
   {
      headline.text = model.headline
      text.text = model.text
      textField.isHidden = !model.showTextField
      textField.text = model.textField
      errorText.text = ""
      
      rightButton.isHidden = model.rightButtonType == nil
      if let btnType = model.rightButtonType {
         setup(button: rightButton, forType: btnType)
      }
      
      leftButton.isHidden = model.leftButtonType == nil
      if let btnType = model.leftButtonType {
         setup(button: leftButton, forType: btnType)
      }
   }
   
   private func setup(button: UIButton, forType type: AlertButtonType)
   {
      switch type {
      case .ok:
         button.setTitle("OK", for: .normal)
         button.setTitleColor(UIColor.tint, for: .normal)
      case .cancel:
         button.setTitle("Cancel", for: .normal)
         button.setTitleColor(UIColor.white, for: .normal)
      case .delete:
         button.setTitle("Delete", for: .normal)
         button.setTitleColor(UIColor.red, for: .normal)
      }
   }
   
   private func isValid(_ text: String) -> Bool
   {
      return !text.isEmpty
   }
   
   private func showEmptyTextWarning()
   {
      errorText.text = "Text can't be empty!"
   }
}

// --------------------------------------------------------------------------------
//MARK: - Action

extension AlertViewController
{
   @IBAction private func onLeftButtonClicked(_ sender: UIButton)
   {
      guard var alertAction = model.leftButtonAction else {
         dispatch(action: MainViewAction.CloseAlert())
         return
      }
      
      processButtonClick(alertAction: &alertAction)
   }
   
   @IBAction private func onRightButtonClicked(_ sender: UIButton)
   {
      guard var alertAction = model.rightButtonAction else {
         dispatch(action: MainViewAction.CloseAlert())
         return
      }
      
      processButtonClick(alertAction: &alertAction)
   }
   
   private func processButtonClick(alertAction: inout TextSetableAction)
   {
      if model.showTextField, let text = textField.text {
         if isValid(text) {
            alertAction.text = text
         } else {
            showEmptyTextWarning()
            return
         }
      }
      
      if let action = alertAction as? Action {
         dispatch(action: action)
      }
      dispatch(action: MainViewAction.CloseAlert())
   }
}

// --------------------------------------------------------------------------------
//MARK: - Keyboard Stuff

extension AlertViewController: UITextFieldDelegate
{
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
   {
      textField.resignFirstResponder()
   }
   
   func textFieldDidBeginEditing(_ textField: UITextField)
   {
      UIView.animate(withDuration: UI.animationDuration) {
         self.alertView.frame.origin.y = 5
      }
   }
   
   func textFieldDidEndEditing(_ textField: UITextField)
   {
      UIView.animate(withDuration: UI.animationDuration) {
         self.alertView.center = self.view.center
      }
   }
}
