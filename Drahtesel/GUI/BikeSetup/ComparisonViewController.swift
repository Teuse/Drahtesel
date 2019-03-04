import UIKit
import ReSwift

class ComparisonViewController: UIViewController
{
   private var colorPicker: ColorPicker = Storyboard.create(name: UI.Storyboard.colorPicker)
   
   @IBOutlet private weak var colorPickerContainer: UIView!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      colorPicker.delegate = self
      embed(colorPicker, in: colorPickerContainer)
      
      subscribe(self) { subcription in
         subcription.select { state in state.setupComparisonState }
      }
      dispatch(action: MainViewAction.OpenedPage(page: .setupComparison))
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - Components Delegate

extension ComparisonViewController: ColorPickerDelegate
{
   func didSelect(color: ColorPalette)
   {
      dispatch(action: SetupComparisonAction.ChangeColor(color: color))
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension ComparisonViewController: StoreSubscriber
{
   func newState(state: SetupComparisonState)
   {
      if let bike = state.bike {
         colorPicker.color = bike.paletteColor
      }
   }
}
