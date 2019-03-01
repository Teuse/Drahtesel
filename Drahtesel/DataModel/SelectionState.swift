import ReSwift

struct SelectionState: StateType
{
   var collections: [Collection] {
      return DBAccess.shared.collections(withType: .user)
   }
   var selected: Collection? = nil
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension SelectionState
{
   static func reducer(action: Action, state: SelectionState?) -> SelectionState {
      var state = state ?? SelectionState()
      
      switch action
      {
      case let action as SelectionAction.Select:
         state.selected = action.collection
         
      case let action as CollectionAction.Add:
         if let name = action.text {
            handleAddedCollection(&state, name)
         }
         
      default: break
      }
      
      return state
   }
   
   static func handleAddedCollection(_ state: inout SelectionState, _ name: String)
   {
      if let col = state.collections.first(where: { $0.name == name }) {
         state.selected = col
      }
   }
}

