import ReSwift

struct SelectionBrowserState: StateType
{
   var collections: [Collection] {
      return DBAccess.shared.collections(withType: .user)
   }
   var selected: Collection? = nil
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension SelectionBrowserState
{
   static func reducer(action: Action, state: SelectionBrowserState?) -> SelectionBrowserState {
      var state = state ?? SelectionBrowserState()
      
      switch action
      {
      case let action as SelectionBrowserAction.Select:
         state.selected = action.collection
         
      case let action as CollectioBrowserAction.Add:
         if let name = action.text {
            handleAddedCollection(&state, name)
         }
         
      default: break
      }
      
      return state
   }
   
   static func handleAddedCollection(_ state: inout SelectionBrowserState, _ name: String)
   {
      if let col = state.collections.first(where: { $0.name == name }) {
         state.selected = col
      }
   }
}

