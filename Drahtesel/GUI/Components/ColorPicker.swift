import UIKit

protocol ColorPickerDelegate: class {
   func didSelect(color: ColorPalette)
}

class ColorPicker: UIViewController
{
   var color: ColorPalette = .black {
      didSet { collectionView?.reloadData() }
   }
   
   weak var delegate: ColorPickerDelegate?
   
   let colors = ColorPalette.allCases
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      collectionView.dataSource = self
      collectionView.delegate = self
   }
}

// --------------------------------------------------------------------------------
//MARK: - Action

extension ColorPicker: UICollectionViewDelegate, UICollectionViewDataSource
{
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return colors.count
   }
   
   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
   {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorPickerCell", for: indexPath) as! ColorPickerCell
      cell.layer.cornerRadius = cell.view.frame.height / 2
      cell.clipsToBounds = true
      let color = colors[indexPath.row]
      cell.color = color.uicolor
      cell.picked = self.color == color
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      delegate?.didSelect(color: colors[indexPath.row])
      collectionView.reloadData()
   }
}
