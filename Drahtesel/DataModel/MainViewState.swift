import ReSwift

struct MainViewState: StateType
{
   var currentPage: Page = .none
   var alertViewModel: AlertViewModel?
   
   var isEditModeEnabled = false
   
   var buttonLarge = true
   var buttonShown = false
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension MainViewState
{
   static func reducer(action: Action, state: MainViewState?) -> MainViewState {
      var state = state ?? MainViewState()
      
      switch action {
      case let action as MainViewAction.OpenedPage:
         state.currentPage = action.page
         updateButton(for: action.page, &state)
      
      case let action as MainViewAction.PresentAlert:
         state.alertViewModel = action.model
         
      case is MainViewAction.CloseAlert:
         state.alertViewModel = nil
         
      case let action as BikeBrowserAction.SetEdit:
         state.isEditModeEnabled = action.enabled
         
      default:
         break
      }
      return state
   }
   
   static private func updateButton(for page: Page, _ state: inout MainViewState)
   {
      switch page {
      case .collectionBrowser:
         state.buttonLarge = true
         state.buttonShown = false
      case .bikeBrowser:
         state.buttonLarge = true
         state.buttonShown = true
      case .setupBasics, .setupGeometry, .setupSpecification:
         state.buttonLarge = false
         state.buttonShown = true
      default: break
      }
   }
}

