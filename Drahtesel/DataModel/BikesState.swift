import ReSwift

struct BikesState: StateType
{
   var pageTitle = ""
   var isEditing = false {
      didSet { if !isEditing { selectedBikes.removeAll() }}
   }
   var isCopyButtonEnabled: Bool { return !selectedBikes.isEmpty }
   var selectedBikes = [Bike]()
   
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
      case let action as CollectionAction.Select:
         handleSelectCollection(&state, action.collection)
      
      case let action as BikeAction.Select:
         assert(state.isEditing, "Selection without edit mode is not implemented yet")
         state.selectedBikes.append(action.bike)
         
      case let action as BikeAction.Deselect:
         assert(state.isEditing)
         state.selectedBikes.removeAll(where: { $0.id == action.bike.id })
         
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
         
      case let action as BikeAction.CopySelectionTo:
         handleCopySelectionTo(&state, action.collection)
         
      case let action as BikeAction.ChangeRating:
         action.bike.rating = Int64(action.rating)
         DBAccess.shared.save()
         state.isDataUpdated = true
         
      case let action as BikeAction.ChangeCompareEnabled:
         action.bike.compareEnabled = action.enabled
         DBAccess.shared.save()
         state.isDataUpdated = true
         
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
   
   static func handleCopySelectionTo(_ state: inout BikesState, _ collection: Collection)
   {
      for bike in state.selectedBikes {
         let new = collection.addBike(name: bike.name!)
         new.copy(from: bike)
      }
   }
}
