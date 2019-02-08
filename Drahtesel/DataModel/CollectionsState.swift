import ReSwift

struct CollectionsState: StateType
{
   var isEditing = false
   
   var isDataUpdated = false
   var collectionTypes = [CollectionType]()
   var collections = [[Collection]]()
   
   func collections(at index: Int) -> [Collection] {
      return collections[index]
   }
   
   func collection(at indexPath: IndexPath) -> Collection {
      let colls = collections(at: indexPath.section)
      return colls[indexPath.row]
   }
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension CollectionsState
{
   static func reducer(action: Action, state: CollectionsState?) -> CollectionsState {
      var state = state ?? CollectionsState()
      state.isDataUpdated = false
      
      switch action
      {
      case let action as AppAction.OpenedPage:
         handleOpenedPage(&state, action.page)

      case let action as CollectionAction.SetEdit:
         state.isEditing = action.enabled
         
      default: break
      }
      return state
   }
   
   static func updateCollectionData(_ state: inout CollectionsState)
   {
      state.collectionTypes.removeAll()
      state.collections.removeAll()
      for type in CollectionType.allCases
      {
         state.collectionTypes.append(type)
         let coll = DBAccess.shared.collections(withType: type)
         state.collections.append(coll)
      }
      state.isDataUpdated = true
   }
   
   static func handleOpenedPage(_ state: inout CollectionsState, _ page: Pages)
   {
      state.isEditing = false
      if page == .collectionBrowser {
         updateCollectionData(&state)
      }
   }
}

