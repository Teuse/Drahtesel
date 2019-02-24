import UIKit
import ReSwift

class SetupBasicsViewController: UIViewController
{
   private var state = BikeSetupState()
   private let ratingViewController = RatingViewController()
   
   @IBOutlet private weak var ratingContainer: UIView!
   
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      ratingViewController.delegate = self
      embed(ratingViewController, in: ratingContainer)
      ratingContainer.backgroundColor = UIColor.clear
      
      subscribe(self) { subcription in
         subcription.select { state in state.bikeSetupState }
      }
      dispatch(action: MainViewAction.OpenedPage(page: .setupBasics))
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   private func updateView(with bike: Bike)
   {
      ratingViewController.rating = Int(bike.rating)
      
   }
}

// --------------------------------------------------------------------------------
//MARK: - Components Delegate

extension SetupBasicsViewController: RatingDelegate
{
   func ratingChanged(to value: Int)
   {
      if let bike = state.bike {
         dispatch(action: BikeSetupAction.ChangeRating(bike: bike, rating: value))
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupBasicsViewController: StoreSubscriber
{
   func newState(state: BikeSetupState)
   {
      self.state = state
      
      if let bike = state.bike {
         updateView(with: bike)
      }
   }
}
