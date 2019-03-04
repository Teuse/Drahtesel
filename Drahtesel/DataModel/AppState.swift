import ReSwift

struct AppState: StateType
{
   var mainViewState = MainViewState()
   var collectionBrowserState = CollectionBrowserState()
   var bikeBrowserState = BikeBrowserState()
   var selectionBrowserState = SelectionBrowserState()
   var bikeSetupState = BikeSetupState()
   var setupBasicsState = SetupBasicsState()
   var setupComparisonState = SetupComparisonState()
   var setupGeometryState = SetupGeometryState()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension AppState
{
   static func reducer(action: Action, state: AppState?) -> AppState {
      var state = state ?? AppState()
      state.mainViewState = MainViewState.reducer(action: action, state: state.mainViewState)
      state.collectionBrowserState = CollectionBrowserState.reducer(action: action, state: state.collectionBrowserState)
      state.bikeBrowserState = BikeBrowserState.reducer(action: action, state: state.bikeBrowserState)
      state.selectionBrowserState = SelectionBrowserState.reducer(action: action, state: state.selectionBrowserState)
      state.bikeSetupState = BikeSetupState.reducer(action: action, state: state.bikeSetupState)
      state.setupBasicsState = SetupBasicsState.reducer(action: action, state: state.setupBasicsState)
      state.setupComparisonState = SetupComparisonState.reducer(action: action, state: state.setupComparisonState)
      state.setupGeometryState = SetupGeometryState.reducer(action: action, state: state.setupGeometryState)
      
      return state
   }
}

