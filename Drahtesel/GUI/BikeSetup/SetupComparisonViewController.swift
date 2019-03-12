import UIKit
import ReSwift

class SetupComparisonViewController: UIViewController, SetupController
{
   private var colorPicker: ColorPicker = Storyboard.create(name: UI.Storyboard.colorPicker)
   
   @IBOutlet private weak var colorPickerContainer: UIView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      colorPicker.delegate = self
      embed(colorPicker, in: colorPickerContainer)
   }
   
   func setupViewWillShow(_ animated: Bool)
   {
      subscribe(self) { subcription in
         subcription.select { state in state.setupComparisonState }
      }
      dispatch(action: MainViewAction.OpenedPage(page: .setupComparison))
   }
   
   func setupViewWillHide(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - Components Delegate

extension SetupComparisonViewController: ColorPickerDelegate
{
   func didSelect(color: ColorPalette)
   {
      dispatch(action: SetupComparisonAction.ChangeColor(color: color))
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension SetupComparisonViewController: StoreSubscriber
{
   func newState(state: SetupComparisonState)
   {
      if let bike = state.bike {
         colorPicker.color = bike.paletteColor
      }
   }
}
