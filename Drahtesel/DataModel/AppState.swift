import ReSwift

struct AppState: StateType
{
   var mainViewState = MainViewState()
   var collectionsState = CollectionsState()
   var bikesState = BikesState()
   var selectionState = SelectionState()
   var bikeSetupState = BikeSetupState()
   var setupGeometryState = SetupGeometryState()
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
      state.selectionState = SelectionState.reducer(action: action, state: state.selectionState)
      state.bikeSetupState = BikeSetupState.reducer(action: action, state: state.bikeSetupState)
      state.setupGeometryState = SetupGeometryState.reducer(action: action, state: state.setupGeometryState)
      
      return state
   }
}

