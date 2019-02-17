import UIKit

class BikeCell: UITableViewCell
{
   var bike: Bike? = nil {
      didSet { updateView() }
   }
   
   @IBOutlet private weak var colorFlagView: TriangleView!
   @IBOutlet private weak var nameLabel: UILabel!
   @IBOutlet private weak var brandLabel: UILabel!
   @IBOutlet private weak var compareSwitch: UISwitch!
   
   @IBOutlet private weak var ratingButton1: UIButton!
   @IBOutlet private weak var ratingButton2: UIButton!
   @IBOutlet private weak var ratingButton3: UIButton!
   @IBOutlet private weak var ratingButton4: UIButton!
   @IBOutlet private weak var ratingButton5: UIButton!
   
   private func updateView()
   {
      guard let bike = bike else { assertionFailure(); return }
      
      nameLabel?.text = bike.name
      brandLabel?.text = bike.brand ?? ""
      compareSwitch.isOn = bike.compareEnabled
      
      ratingButton1.setImage(image(for: 1, rating: Int(bike.rating)), for: .normal)
      ratingButton2.setImage(image(for: 2, rating: Int(bike.rating)), for: .normal)
      ratingButton3.setImage(image(for: 3, rating: Int(bike.rating)), for: .normal)
      ratingButton4.setImage(image(for: 4, rating: Int(bike.rating)), for: .normal)
      ratingButton5.setImage(image(for: 5, rating: Int(bike.rating)), for: .normal)
      
      let color = bike.color as! UIColor
      colorFlagView.fillColor = color
      compareSwitch.onTintColor = color
   }
   
   private func image(for buttonNr: Int, rating: Int) -> UIImage
   {
      if rating == 0 {
         return UIImage(named: "RatingStarDisabled")!
      }
      return buttonNr <= rating
         ? UIImage(named: "RatingStarOn")!
         : UIImage(named: "RatingStarOff")!
   }
   
   //MARK: Actions
   
   @IBAction private func onRatingStarClicked(_ sender: UIButton)
   {
      guard let bike = bike else { assertionFailure(); return }
      
      let action = BikeAction.ChangeRating(bike: bike, rating: sender.tag)
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.dispatch(action)
      
      updateView()
   }
   
   @IBAction private func onCompareSwitchChanged(_ sender: UISwitch)
   {
      guard let bike = bike else { assertionFailure(); return }
      
      let action = BikeAction.ChangeCompareEnabled(bike: bike, enabled: sender.isOn)
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.dispatch(action)
   }
}

