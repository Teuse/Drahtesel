import ReSwift

struct BikesState: StateType
{
   var pageTitle = ""
   var isEditing = false
   
   var isDataUpdated = false
   var bikes = [Bike]()
   
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension BikesState
{
   static func reducer(action: Action, state: BikesState?) -> BikesState {
      var state = state ?? BikesState()
      state.isDataUpdated = false
     
      switch action
      {
      case let action as AppAction.OpenedPage:
         handleOpenedPage(&state, action.page)
      case let action as CollectionAction.Select:
         handleSelectCollection(&state, action.collection)
      
      case let action as BikeAction.SetEdit:
         state.isEditing = action.enabled
         
      default: break
      }
      return state
   }
   
   static func handleSelectCollection(_ state: inout BikesState, _ collection: Collection)
   {
      state.pageTitle = collection.name ?? "Bikes"
      state.bikes = collection.bikes
      state.isDataUpdated = true
   }
   
   static func handleOpenedPage(_ state: inout BikesState, _ page: Pages)
   {
      state.isEditing = false
   }
}

