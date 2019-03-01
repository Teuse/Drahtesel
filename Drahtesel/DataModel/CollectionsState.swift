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
      case let action as MainViewAction.OpenedPage:
         handleOpenedPage(&state, action.page)

      case let action as CollectionAction.SetEdit:
         state.isEditing = action.enabled
      
      case let action as CollectionAction.Add:
         if let name = action.text {
            handleAdd(&state, name)
         }
         
      case let action as CollectionAction.Rename:
         if let name = action.text {
            handleRename(&state, action.collection, name)
         }
         
      case let action as CollectionAction.Duplicate:
         if let name = action.text {
            handleDuplicate(&state, action.collection, name)
         }
         
      case let action as CollectionAction.Delete:
         handleDelete(&state, action.collection)
         
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
   
   static func handleAdd(_ state: inout CollectionsState, _ name: String)
   {
      _ = DBAccess.shared.addCollection(name: name)
      DBAccess.shared.save()
      updateCollectionData(&state)
   }
   
   static func handleRename(_ state: inout CollectionsState, _ collection: Collection, _ name: String)
   {
      collection.name = name
      DBAccess.shared.save()
      updateCollectionData(&state)
   }
   
   static func handleDuplicate(_ state: inout CollectionsState, _ collection: Collection, _ name: String)
   {
      let newCollection = DBAccess.shared.addCollection(name: name)
      newCollection.copy(from: collection)
      newCollection.type = .user
      newCollection.name = name
      DBAccess.shared.save()
      updateCollectionData(&state)
   }
   
   static func handleDelete(_ state: inout CollectionsState, _ collection: Collection)
   {
      DBAccess.shared.delete(collection: collection)
      DBAccess.shared.save()
      updateCollectionData(&state)
   }
}

