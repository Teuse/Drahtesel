import ReSwift

struct BikesState: StateType
{
   var pageTitle = ""
   var isEditing = false
   
   var isDataUpdated = false
   var collection = Collection()
   var bikes: [Bike] { return collection.bikes }
   
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
      case let action as MainViewAction.OpenedPage:
         handleOpenedPage(&state, action.page)
      case let action as CollectionAction.Select:
         handleSelectCollection(&state, action.collection)
      
      case let action as BikeAction.SetEdit:
         state.isEditing = action.enabled
         
      case let action as BikeAction.Add:
         handleAdd(&state, action.name)
      
      case let action as BikeAction.Rename:
         handleRename(&state, action.bike, action.name)
         
      case let action as BikeAction.Duplicate:
         handleDuplicate(&state, action.bike, action.name)
         
      case let action as BikeAction.Delete:
         handleDelete(&state, action.bike)
         
      default: break
      }
      return state
   }
   
   static func handleSelectCollection(_ state: inout BikesState, _ collection: Collection)
   {
      state.pageTitle = collection.name ?? "Bikes"
      state.collection = collection
      state.isDataUpdated = true
   }
   
   static func handleOpenedPage(_ state: inout BikesState, _ page: Pages)
   {
      state.isEditing = false
   }
   
   static func handleAdd(_ state: inout BikesState, _ name: String)
   {
      _ = state.collection.addBike(name: name)
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
   
   static func handleRename(_ state: inout BikesState, _ bike: Bike, _ name: String)
   {
      bike.name = name
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
   
   static func handleDuplicate(_ state: inout BikesState, _ bike: Bike, _ name: String)
   {
      let newBike = state.collection.addBike(name: name)
      newBike.copy(from: bike)
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
   
   static func handleDelete(_ state: inout BikesState, _ bike: Bike)
   {
      state.collection.delete(bike: bike)
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
}

