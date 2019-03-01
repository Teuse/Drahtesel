import Foundation
import ReSwift

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
   var leftButtonAction: TextSetableAction? = nil
   
   var rightButtonType: AlertButtonType? = nil
   var rightButtonAction: TextSetableAction? = nil
   
   //MARK: - Life Circle
   
   init(headline: String, text: String) {
      self.headline = headline
      self.text = text
   }
   
   mutating func leftButton(type: AlertButtonType, action: TextSetableAction? = nil)
   {
      leftButtonType = type
      leftButtonAction = action
   }
   
   mutating func rightButton(type: AlertButtonType, action: TextSetableAction? = nil)
   {
      rightButtonType = type
      rightButtonAction = action
   }
}
