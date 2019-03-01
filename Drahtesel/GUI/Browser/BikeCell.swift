import UIKit

class BikeCell: UITableViewCell
{
   var bike: Bike? = nil {
      didSet { updateView() }
   }
   
   private var ratingViewController: RatingViewController? = nil
   
   @IBOutlet private weak var colorFlagView: TriangleView!
   @IBOutlet private weak var nameLabel: UILabel!
   @IBOutlet private weak var brandLabel: UILabel!
   @IBOutlet private weak var compareSwitch: UISwitch!
   @IBOutlet private weak var ratingContainer: UIView!
   
   private func updateView()
   {
      guard let bike = bike else { assertionFailure(); return }
      
      if ratingViewController == nil {
         ratingViewController = RatingViewController()
         ratingViewController?.delegate = self
         ratingContainer.embed(view: ratingViewController!.view)
         ratingContainer.backgroundColor = UIColor.white
      }
      ratingViewController?.rating = Int(bike.rating)
      
      nameLabel?.text = bike.name
      brandLabel?.text = bike.brand
      compareSwitch.isOn = bike.compareEnabled
      
      let color = bike.color as! UIColor
      colorFlagView.fillColor = color
      compareSwitch.onTintColor = color
   }
   
   //MARK: Actions
   
   @IBAction private func onCompareSwitchChanged(_ sender: UISwitch)
   {
      guard let bike = bike else { assertionFailure(); return }
      
      let action = BikeSetupAction.ChangeCompareEnabled(bike: bike, enabled: sender.isOn)
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.dispatch(action)
   }
}

// --------------------------------------------------------------------------------
//MARK: - Rating Delegate

extension BikeCell: RatingDelegate
{
   func ratingChanged(to value: Int)
   {
      guard let bike = bike else { assertionFailure(); return }
      
      let action = BikeSetupAction.ChangeRating(bike: bike, rating: value)
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.dispatch(action)
      
      updateView()
   }
}
