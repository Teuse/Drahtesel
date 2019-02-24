import UIKit

class ColorPickerCell: UICollectionViewCell
{
   @IBOutlet weak var view: UIView!
   @IBOutlet weak var selection: UILabel!
   
   var picked: Bool {
      get { return !self.selection.isHidden }
      set { self.selection.isHidden = !newValue }
   }
   
   var color: UIColor {
      get { return self.view.backgroundColor ?? UIColor.black }
      set { self.view.backgroundColor = newValue }
   }
}
