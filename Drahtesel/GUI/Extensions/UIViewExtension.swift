import UIKit

extension UIView
{
   enum Anchors
   {
      case left, right, top, bottom
      case width, height
      
      func toConstrint() -> NSLayoutConstraint.Attribute
      {
         switch self {
         case .left:    return NSLayoutConstraint.Attribute.left
         case .right:   return NSLayoutConstraint.Attribute.right
         case .top:     return NSLayoutConstraint.Attribute.top
         case .bottom:  return NSLayoutConstraint.Attribute.bottom
         case .width:   return NSLayoutConstraint.Attribute.width
         case .height:  return NSLayoutConstraint.Attribute.height
         }
      }
   }
   
   
   func embed(view: UIView)
   {
      addSubview(view)
      anchor(.top, to: view, destAnchor: .top)
      anchor(.bottom, to: view, destAnchor: .bottom)
      anchor(.left, to: view, destAnchor: .left)
      anchor(.right, to: view, destAnchor: .right)
   }
   
   func anchor(_ anchor: Anchors, to view: UIView, destAnchor: Anchors)
   {
      translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint(item: self, attribute: anchor.toConstrint(),
                         relatedBy: NSLayoutConstraint.Relation.equal,
                         toItem: view, attribute: destAnchor.toConstrint(),
                         multiplier: 1, constant: 0).isActive = true
   }
}
