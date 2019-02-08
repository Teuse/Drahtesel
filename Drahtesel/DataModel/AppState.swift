import ReSwift

struct AppState: StateType
{
   var collectionsState = CollectionsState()
   var bikesState = BikesState()
   
   var currentPage: Pages = .none
   var buttonLarge = true
   var buttonHidden = true
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension AppState
{
   static func reducer(action: Action, state: AppState?) -> AppState {
      var state = state ?? AppState()
      state.collectionsState = CollectionsState.reducer(action: action, state: state.collectionsState)
      state.bikesState = BikesState.reducer(action: action, state: state.bikesState)
      
      switch action {
      case let action as AppAction.OpenedPage:
         handleOpenedPage(&state, action.page)
      case let action as BikeAction.SetEdit:
         state.buttonHidden = action.enabled
      default:
         break
      }
      
      return state
   }
   
   static func handleOpenedPage(_ state: inout AppState, _ page: Pages)
   {
      state.currentPage = page
      
      switch page {
      case .collectionBrowser:
         state.buttonHidden = true
      case .bikeBrowser:
         state.buttonHidden = false
         state.buttonLarge = true
      case .setupBasics, .setupGeometry, .setupSpecification:
         state.buttonHidden = false
         state.buttonLarge = false
      default:
         break
      }
   }
}

