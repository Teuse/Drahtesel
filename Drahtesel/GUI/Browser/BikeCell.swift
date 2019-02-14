import UIKit

class BikeCell: UITableViewCell
{
   @IBOutlet private weak var colorFlagView: TriangleView!
   @IBOutlet private weak var nameLabel: UILabel!
   @IBOutlet private weak var brandLabel: UILabel!
   
   var name: String {
      get { return nameLabel?.text ?? "" }
      set { nameLabel?.text = newValue }
   }
   
   var brand: String {
      get { return brandLabel?.text ?? "" }
      set { brandLabel?.text = newValue }
   }
   
//   var colorFlag = TriangleView(frame: CGRect(x:0, y:0, width:0, height:0))
   
//   var bikeColor: UIColor {
//      get { return self.colorFlag.fillColor }
//      set { self.colorFlag.fillColor = newValue }
//   }
   
//   override func layoutSubviews() {
//      super.layoutSubviews()
//
//      let flagEdge = self.frame.height/2.0
//      let flagRect = CGRect(x: self.frame.width-flagEdge, y:0, width: flagEdge, height: flagEdge)
//      self.colorFlag.frame = flagRect
//      self.addSubview(self.colorFlag)
//   }
}

