import ReSwift

struct BikeSetupState: StateType
{
   var bike: Bike?
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension BikeSetupState
{
   static func reducer(action: Action, state: BikeSetupState?) -> BikeSetupState {
      var state = state ?? BikeSetupState()
      
      switch action
      {
      case let action as BikeAction.OpenBike:
         state.bike = action.bike
         
      case let action as BikeSetupAction.ChangeRating:
         action.bike.rating = Int64(action.rating)
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeCompareEnabled:
         action.bike.compareEnabled = action.enabled
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeColor:
         action.bike.color = action.color.uicolor
         DBAccess.shared.save()
         
      default: break
      }
      
      return state
   }
}

