import ReSwift

struct BikeSetupState: StateType
{
   var bike: Bike?
   
   var basicsModel = [PropertyModel]()
   var geometryModel = [PropertyModel]()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension BikeSetupState
{
   static func reducer(action: Action, state: BikeSetupState?) -> BikeSetupState {
      var state = state ?? BikeSetupState()
      
      switch action
      {
      case let action as MainViewAction.OpenedPage:
         if action.page == .setupBasics {
            updateBasicPropertiesModel(&state)
         } else if action.page == .setupGeometry {
            updateGeometryPropertiesModel(&state)
         }
         
      case let action as BikeAction.OpenBike:
         state.bike = action.bike
         
      case let action as BikeSetupAction.ChangeName:
         if let name = action.text {
            action.bike.name = name
            DBAccess.shared.save()
            updateBasicPropertiesModel(&state)
         }
      
      case let action as BikeSetupAction.ChangeBrand:
         if let name = action.text {
            action.bike.brand = name
            DBAccess.shared.save()
            updateBasicPropertiesModel(&state)
         }
         
      case let action as BikeSetupAction.ChangeModelYear:
         if let yearStr = action.text, let year = Int(yearStr) {
            action.bike.year = year
            DBAccess.shared.save()
            updateBasicPropertiesModel(&state)
         }
         
      case let action as BikeSetupAction.ChangePrice:
         if let priceStr = action.text, let price = Double(priceStr) {
            action.bike.price = price
            DBAccess.shared.save()
            updateBasicPropertiesModel(&state)
         }
      
      case let action as BikeSetupAction.ChangeCategory:
         action.bike.category = action.category
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeIsElectrified:
         action.bike.isElectrified = action.isElectro
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeRating:
         action.bike.rating = action.rating
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeCompareEnabled:
         action.bike.compareEnabled = action.enabled
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeColor:
         action.bike.color = action.color.uicolor
         DBAccess.shared.save()
         
      default: break
      }
      
      return state
   }
   
   static func updateBasicPropertiesModel(_ state: inout BikeSetupState)
   {
      guard let bike = state.bike else {
         assertionFailure("BikeSetupState->updateBasicPropertiesModel: Can't create model because bike is nil")
         return
      }
      
      let year = "\(bike.year)"
      let price = "\(bike.price)"
      
      state.basicsModel = [
         PropertyModel(name: "NAME", label: bike.name, action: BikeSetupAction.ChangeName(bike: bike)),
         PropertyModel(name: "BRAND", label: bike.brand, action: BikeSetupAction.ChangeBrand(bike: bike)),
         PropertyModel(name: "MODEL YEAR", label: year, action: BikeSetupAction.ChangeModelYear(bike: bike)),
         PropertyModel(name: "PRICE", label: price, action: BikeSetupAction.ChangePrice(bike: bike)),
      ]
   }
   
   static func updateGeometryPropertiesModel(_ state: inout BikeSetupState)
   {
      guard let bike = state.bike, let geo = bike.geometry else {
         assertionFailure("BikeSetupState->updateGeometryPropertiesModel: Can't create model because bike/geometry is nil")
         return
      }
      
      state.geometryModel = [
         PropertyModel(name: "REACH", label: "\(Int(geo.reach))", action: BikeSetupAction.ChangeReach(bike: bike)),
         PropertyModel(name: "STACK", label: "\(Int(geo.stack))", action: BikeSetupAction.ChangeStack(bike: bike)),
         PropertyModel(name: "CHAINSTAY", label: "\(Int(geo.chainstay))", action: BikeSetupAction.ChangeChainstay(bike: bike)),
         PropertyModel(name: "WHEEL BASE", label: "\(Int(geo.wheelbase))", action: BikeSetupAction.ChangeWheelbase(bike: bike)),
//         PropertyModel(name: "HEAD TUBE", label: bike.brand, action: BikeSetupAction.ChangeHeadTubeAngle(bike: bike)),
         PropertyModel(name: "HEAD TUBE ANGLE", label: "\(geo.headTubeAngle)", action: BikeSetupAction.ChangeHeadTubeAngle(bike: bike)),
         PropertyModel(name: "SEAT TUBE", label: "\(Int(geo.seatTube))", action: BikeSetupAction.ChangeSeatTube(bike: bike)),
         PropertyModel(name: "SEAT ANGLE", label: "\(geo.seatTubeAngle)", action: BikeSetupAction.ChangeSeatTubeAngle(bike: bike)),
         PropertyModel(name: "BB Drop", label: "\(Int(geo.bbDrop))", action: BikeSetupAction.ChangeBBDrop(bike: bike)),
         //         PropertyModel(name: "BB OFFSET", label: price, action: BikeSetupAction.ChangeBBOffset(bike: bike)),
         PropertyModel(name: "TOP TUBE", label: "\(Int(geo.topTube))", action: BikeSetupAction.ChangeTopTube(bike: bike)),
         //         PropertyModel(name: "STANDOVER HEIGHT", label: price, action: BikeSetupAction.ChangeStandoverHeight(bike: bike)),
      ]
   }
}

