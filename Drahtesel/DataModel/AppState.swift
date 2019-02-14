import ReSwift

struct AppState: StateType
{
   var mainViewState = MainViewState()
   var collectionsState = CollectionsState()
   var bikesState = BikesState()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension AppState
{
   static func reducer(action: Action, state: AppState?) -> AppState {
      var state = state ?? AppState()
      state.mainViewState = MainViewState.reducer(action: action, state: state.mainViewState)
      state.collectionsState = CollectionsState.reducer(action: action, state: state.collectionsState)
      state.bikesState = BikesState.reducer(action: action, state: state.bikesState)
      
      return state
   }
}
