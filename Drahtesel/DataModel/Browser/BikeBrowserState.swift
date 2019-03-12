import ReSwift

struct BikeBrowserState: StateType
{
   var pageTitle = ""
   var isEditing = false {
      didSet { if !isEditing { selectedBikes.removeAll() }}
   }
   var isCopyButtonEnabled: Bool { return !selectedBikes.isEmpty }
   var selectedBikes = [Bike]()
   
   var isDataUpdated = false
   var collection: Collection? = nil
   
   var bikes: [Bike]
   {
      assert(collection != nil)
      var bikes = collection?.bikes ?? [Bike]()
      bikes.sort(by: { $0.brand != $1.brand ? $0.brand < $1.brand : $0.name < $1.name })
      return bikes
   }
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension BikeBrowserState
{
   static func reducer(action: Action, state: BikeBrowserState?) -> BikeBrowserState {
      var state = state ?? BikeBrowserState()
      state.isDataUpdated = false
     
      switch action
      {
      case let action as MainViewAction.OpenedPage:
         handleOpenedPage(&state, action.page)
         
      case let action as CollectioBrowserAction.Select:
         handleSelectCollection(&state, action.collection)
      
      case let action as BikeBrowserAction.Select:
         assert(state.isEditing, "Selection without edit mode is not implemented yet")
         state.selectedBikes.append(action.bike)
         
      case let action as BikeBrowserAction.Deselect:
         assert(state.isEditing)
         state.selectedBikes.removeAll(where: { $0.id == action.bike.id })
         
      case let action as BikeBrowserAction.SetEdit:
         state.isEditing = action.enabled
         
      case let action as BikeBrowserAction.Add:
         if let name = action.text {
            handleAdd(&state, name)
         }
      
      case let action as BikeBrowserAction.Rename:
         if let name = action.text {
            handleRename(&state, action.bike, name)
         }
         
      case let action as BikeBrowserAction.Duplicate:
         if let name = action.text {
            handleDuplicate(&state, action.bike, name)
         }
         
      case let action as BikeBrowserAction.Delete:
         handleDelete(&state, action.bike)
         
      case let action as BikeBrowserAction.CopySelectionTo:
         handleCopySelectionTo(&state, action.collection)
         
      case let action as BikeBrowserAction.ChangeRating:
         action.bike.rating = action.rating
         DBAccess.shared.save()
         state.isDataUpdated = true
         
      case let action as BikeBrowserAction.ChangeCompareEnabled:
         action.bike.compareEnabled = action.enabled
         DBAccess.shared.save()
         state.isDataUpdated = true
         
      default: break
      }
      return state
   }
   
   static func handleOpenedPage(_ state: inout BikeBrowserState, _ page: Page)
   {
      if page == .bikeBrowser {
         state.isDataUpdated = true
      }
   }
   
   static func handleSelectCollection(_ state: inout BikeBrowserState, _ collection: Collection)
   {
      state.pageTitle = collection.name
      state.collection = collection
      state.isDataUpdated = true
   }
   
   static func handleAdd(_ state: inout BikeBrowserState, _ name: String)
   {
      guard let collection = state.collection else { assertionFailure(); return }
      
      _ = collection.addBike(name: name)
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
   
   static func handleRename(_ state: inout BikeBrowserState, _ bike: Bike, _ name: String)
   {
      bike.name = name
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
   
   static func handleDuplicate(_ state: inout BikeBrowserState, _ bike: Bike, _ name: String)
   {
      guard let collection = state.collection else { assertionFailure(); return }
      
      let newBike = collection.addBike(name: name)
      newBike.copy(from: bike)
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
   
   static func handleDelete(_ state: inout BikeBrowserState, _ bike: Bike)
   {
      guard let collection = state.collection else { assertionFailure(); return }
      
      collection.delete(bike: bike)
      DBAccess.shared.save()
      state.isDataUpdated = true
   }
   
   static func handleCopySelectionTo(_ state: inout BikeBrowserState, _ collection: Collection)
   {
      for bike in state.selectedBikes {
         let new = collection.addBike(name: bike.name)
         new.copy(from: bike)
      }
   }
}
