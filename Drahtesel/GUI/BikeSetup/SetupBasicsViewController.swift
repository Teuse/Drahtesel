import UIKit
import ReSwift

class SetupBasicsViewController: UIViewController, SetupController
{
   private let categories = BikeCategory.allCases
   
   private let ratingViewController = RatingViewController()
   private let propertiesViewController: PropertiesViewController = Storyboard.create(name: UI.Storyboard.properties)
   
   @IBOutlet private weak var ratingContainer: UIView!
   @IBOutlet private weak var propertiesContainer: UIView!
   @IBOutlet weak var categoryPicker: UIPickerView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      self.categoryPicker.delegate = self
      self.categoryPicker.dataSource = self
      
      ratingViewController.delegate = self
      embed(ratingViewController, in: ratingContainer)
      ratingContainer.backgroundColor = UIColor.clear
      
      embed(propertiesViewController, in: propertiesContainer)
   }
   
   func setupViewWillShow(_ animated: Bool)
   {
      subscribe(self) { subcription in
         subcription.select { state in state.setupBasicsState }
      }
      dispatch(action: MainViewAction.OpenedPage(page: .setupBasics))
   }
   
   func setupViewWillHide(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }

   private func updateView(with bike: Bike)
   {
      ratingViewController.rating = Int(bike.rating)
      categoryPicker.selectRow(Int(bike.category.rawValue), inComponent: 0, animated: false)
   }
   
   @IBAction private func onElectrifiedSwitchChanged(_ sender: UISwitch)
   {
      let action = SetupBasicsAction.ChangeIsElectrified(isElectro: sender.isOn)
      dispatch(action: action)
   }
}

// --------------------------------------------------------------------------------
//MARK: - Components Delegate

extension SetupBasicsViewController: RatingDelegate
{
   func ratingChanged(to value: Int)
   {
      dispatch(action: SetupBasicsAction.ChangeRating(rating: value))
   }
}

//----------------------------------------------------------------------------------------
//MARK: - Category Picker

extension SetupBasicsViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return categories.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
   {
      let text = categories[row].description()
      return text
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
   {
      let category = BikeCategory(rawValue: Int64(row)) ?? .hardtail
      let action = SetupBasicsAction.ChangeCategory(category: category)
      dispatch(action: action)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupBasicsViewController: StoreSubscriber
{
   func newState(state: SetupBasicsState)
   {
      propertiesViewController.properties = state.basicsModel
      
      if let bike = state.bike {
         updateView(with: bike)
      }
   }
}
