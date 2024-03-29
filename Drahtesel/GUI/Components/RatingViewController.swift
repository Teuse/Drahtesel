import UIKit

protocol RatingDelegate: class {
   func ratingChanged(to value: Int)
}

class RatingViewController: UIViewController
{
   var rating: Int = 0 {
      didSet { updateView() }
   }
   
   weak var delegate: RatingDelegate?
   
   @IBOutlet private weak var ratingButton1: UIButton!
   @IBOutlet private weak var ratingButton2: UIButton!
   @IBOutlet private weak var ratingButton3: UIButton!
   @IBOutlet private weak var ratingButton4: UIButton!
   @IBOutlet private weak var ratingButton5: UIButton!
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      updateView()
   }
   
   private func updateView()
   {
      ratingButton1.setImage(image(for: 1, rating: rating), for: .normal)
      ratingButton1.setImage(image(for: 1, rating: rating), for: .highlighted)
      
      ratingButton2.setImage(image(for: 2, rating: rating), for: .normal)
      ratingButton2.setImage(image(for: 2, rating: rating), for: .highlighted)
      
      ratingButton3.setImage(image(for: 3, rating: rating), for: .normal)
      ratingButton3.setImage(image(for: 3, rating: rating), for: .highlighted)
      
      ratingButton4.setImage(image(for: 4, rating: rating), for: .normal)
      ratingButton4.setImage(image(for: 4, rating: rating), for: .highlighted)
      
      ratingButton5.setImage(image(for: 5, rating: rating), for: .normal)
      ratingButton5.setImage(image(for: 5, rating: rating), for: .highlighted)
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
   
   @IBAction private func onRatingClicked(_ sender: UIButton)
   {
      let newRating = sender.tag
      delegate?.ratingChanged(to: newRating)
      rating = newRating
   }
}
