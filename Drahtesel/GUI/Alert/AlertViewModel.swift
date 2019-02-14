import Foundation
import ReSwift

protocol AlertableAction {
   mutating func setAlertText(_ text: String)
}

enum AlertButtonType {
   case delete, ok, cancel
}

struct AlertViewModel
{
   let headline: String
   let text: String
   var showTextField: Bool = false
   var textField: String = ""
   
   var leftButtonType: AlertButtonType? = nil
   var leftButtonAction: AlertableAction? = nil
   
   var rightButtonType: AlertButtonType? = nil
   var rightButtonAction: AlertableAction? = nil
   
   //MARK: - Life Circle
   
   init(headline: String, text: String) {
      self.headline = headline
      self.text = text
   }
   
   mutating func leftButton(type: AlertButtonType, action: AlertableAction? = nil)
   {
      leftButtonType = type
      leftButtonAction = action
   }
   
   mutating func rightButton(type: AlertButtonType, action: AlertableAction? = nil)
   {
      rightButtonType = type
      rightButtonAction = action
   }
}
