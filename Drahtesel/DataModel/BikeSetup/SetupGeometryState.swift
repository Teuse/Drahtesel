import ReSwift

struct SetupGeometryState: StateType
{
   var bike: Bike?
   
   var model = [PropertyModel]()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension SetupGeometryState
{
   static func reducer(action: Action, state: SetupGeometryState?) -> SetupGeometryState {
      var state = state ?? SetupGeometryState()
      
      switch action
      {
      case let action as MainViewAction.OpenedPage:
         if action.page == .setupGeometry {
            updatePropertiesModel(&state)
         }
         
      case let action as BikeBrowserAction.OpenBike:
         state.bike = action.bike
         
      case let action as SetupGeometryAction.ChangeReach:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.reach = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeStack:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.reach = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeChainstay:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.chainstay = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeWheelbase:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.wheelbase = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeHeadTubeAngle:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.headTubeAngle = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeSeatTube:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.seatTube = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeSeatTubeAngle:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.seatTubeAngle = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeBBDrop:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.bbDrop = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupGeometryAction.ChangeTopTube:
         if let valueStr = action.text, let value = Double(valueStr) {
            state.bike?.geometry?.topTube = value
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      default: break
      }
      
      return state
   }
   
   static func updatePropertiesModel(_ state: inout SetupGeometryState)
   {
      guard let bike = state.bike, let geo = bike.geometry else {
         assertionFailure("BikeSetupState->updateGeometryPropertiesModel: Can't create model because bike/geometry is nil")
         return
      }
      
      state.model = [
         PropertyModel(name: "REACH", label: "\(Int(geo.reach))", action: SetupGeometryAction.ChangeReach()),
         PropertyModel(name: "STACK", label: "\(Int(geo.stack))", action: SetupGeometryAction.ChangeStack()),
         PropertyModel(name: "CHAINSTAY", label: "\(Int(geo.chainstay))", action: SetupGeometryAction.ChangeChainstay()),
         PropertyModel(name: "WHEEL BASE", label: "\(Int(geo.wheelbase))", action: SetupGeometryAction.ChangeWheelbase()),
//         PropertyModel(name: "HEAD TUBE", label: bike.brand, action: SetupGeoAction.ChangeHeadTubeAngle()),
         PropertyModel(name: "HEAD TUBE ANGLE", label: "\(geo.headTubeAngle)", action: SetupGeometryAction.ChangeHeadTubeAngle()),
         PropertyModel(name: "SEAT TUBE", label: "\(Int(geo.seatTube))", action: SetupGeometryAction.ChangeSeatTube()),
         PropertyModel(name: "SEAT ANGLE", label: "\(geo.seatTubeAngle)", action: SetupGeometryAction.ChangeSeatTubeAngle()),
         PropertyModel(name: "BB Drop", label: "\(Int(geo.bbDrop))", action: SetupGeometryAction.ChangeBBDrop()),
         //         PropertyModel(name: "BB OFFSET", label: price, action: SetupGeoAction.ChangeBBOffset()),
         PropertyModel(name: "TOP TUBE", label: "\(Int(geo.topTube))", action: SetupGeometryAction.ChangeTopTube()),
         //         PropertyModel(name: "STANDOVER HEIGHT", label: price, action: SetupGeoAction.ChangeStandoverHeight()),
      ]
   }
}

