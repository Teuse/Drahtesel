import ReSwift

struct SetupComparisonState: StateType
{
   var bike: Bike?
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension SetupComparisonState
{
   static func reducer(action: Action, state: SetupComparisonState?) -> SetupComparisonState {
      var state = state ?? SetupComparisonState()
      
      switch action
      {
      case let action as BikeBrowserAction.OpenBike:
         state.bike = action.bike
         
      case let action as SetupComparisonAction.ChangeCompareEnabled:
         state.bike?.compareEnabled = action.enabled
         DBAccess.shared.save()
         
      case let action as SetupComparisonAction.ChangeColor:
         state.bike?.color = action.color.uicolor
         DBAccess.shared.save()
         
      default: break
      }
      
      return state
   }
}

