import UIKit

extension UIView
{ 
   func embed(view: UIView)
   {
      view.translatesAutoresizingMaskIntoConstraints = true
      view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
      addSubview(view)
   }
}
