import UIKit
import ReSwift

class PropertiesCell: UITableViewCell
{
   var property: PropertyModel? = nil {
      didSet { updateView() }
   }
   
   var letter: String = "" {
      didSet { updateView() }
   }

   
   @IBOutlet weak private var label: UILabel!
   @IBOutlet weak private var textField: UITextField!
   
   @IBOutlet weak private var letterView: UIView?
   @IBOutlet weak private var letterLabel: UILabel?
   
   private func updateView()
   {
      guard let prop = property else {
         return
      }
      label.text = prop.name
      textField.text = prop.label
      
      if let letterView = letterView, let letterLabel = letterLabel {
         letterView.layer.cornerRadius = letterView.frame.height / 2
         letterLabel.text = letter
      }
   }
}

extension PropertiesCell: UITextFieldDelegate
{
   func textFieldDidEndEditing(_ textField: UITextField)
   {
      guard var action = property?.action else { return }
      
      action.text = textField.text
      
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.dispatch(action as! Action)
   }
}
