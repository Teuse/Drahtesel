import UIKit

class TriangleView : UIView
{
   var fillColor: UIColor = .purple {
      didSet { self.setNeedsDisplay() }
   }

   override init(frame: CGRect)
   {
      super.init(frame: frame)
      fillColor = backgroundColor ?? .purple
      backgroundColor = UIColor.clear
   }
   
   required init?(coder aDecoder: NSCoder)
   {
      super.init(coder: aDecoder)
      fillColor = backgroundColor ?? .purple
      backgroundColor = UIColor.clear
   }
   
   override func draw(_ rect: CGRect)
   {
      guard let context = UIGraphicsGetCurrentContext() else {
         assertionFailure("TriangleView: Failed to get UIGraphicsGetCurrentContext")
         return
      }

      context.beginPath()
      context.move(to: CGPoint(x: rect.minX, y: rect.minY))
      context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//      context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//      context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
      context.closePath()
      
      context.setFillColor(fillColor.cgColor)
      context.fillPath()
   }
}
