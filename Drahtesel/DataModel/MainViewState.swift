import ReSwift

struct MainViewState: StateType
{
   var currentPage: Pages = .none
   var alertViewModel: AlertViewModel?
   
   var isEditModeEnabled = false
   
   
   var buttonLarge: Bool {
      return currentPage == .collectionBrowser
         || currentPage == .bikeBrowser
   }
   var buttonShown: Bool {
      return (currentPage == .bikeBrowser && !isEditModeEnabled)
         || currentPage == .setupBasics
         || currentPage == .setupGeometry
         || currentPage == .setupSpecification
   }
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
      
      case let action as MainViewAction.PresentAlert:
         state.alertViewModel = action.model
         
      case is MainViewAction.CloseAlert:
         state.alertViewModel = nil
         
      case let action as BikeAction.SetEdit:
         state.isEditModeEnabled = action.enabled
         
      default:
         break
      }
      
      return state
   }
}

