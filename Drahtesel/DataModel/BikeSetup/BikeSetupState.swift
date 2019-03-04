import ReSwift

struct BikeSetupState: StateType
{
   var lastSetupPage: Page = .setupBasics
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension BikeSetupState
{
   static func reducer(action: Action, state: BikeSetupState?) -> BikeSetupState {
      var state = state ?? BikeSetupState()
      
      switch action
      {
      case let action as MainViewAction.OpenedPage:
         if isSetupPage(action.page) {
            state.lastSetupPage = action.page
         }

      default: break
      }
      return state
   }
   
   static func isSetupPage(_ page: Page) -> Bool
   {
      return page == .setupBasics || page == .setupGeometry
          || page == .setupComparison || page == .setupSpecification
   }
}

