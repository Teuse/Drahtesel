import ReSwift

struct SetupBasicsState: StateType
{
   var bike: Bike?
   var basicsModel = [PropertyModel]()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension SetupBasicsState
{
   static func reducer(action: Action, state: SetupBasicsState?) -> SetupBasicsState {
      var state = state ?? SetupBasicsState()
      
      switch action
      {
      case let action as MainViewAction.OpenedPage:
         if action.page == .setupBasics {
            updatePropertiesModel(&state)
         }
         
      case let action as BikeBrowserAction.OpenBike:
         state.bike = action.bike
         
      case let action as SetupBasicsAction.ChangeName:
         if let name = action.text {
            state.bike?.name = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
      
      case let action as SetupBasicsAction.ChangeBrand:
         if let name = action.text {
            state.bike?.brand = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupBasicsAction.ChangeSize:
         if let name = action.text {
            state.bike?.size = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupBasicsAction.ChangeModelYear:
         if let yearStr = action.text, let year = Int(yearStr) {
            state.bike?.year = year
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupBasicsAction.ChangeWeight:
         if let weightStr = action.text, let weight = Double(weightStr) {
            state.bike?.weight = weight
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupBasicsAction.ChangePrice:
         if let priceStr = action.text, let price = Double(priceStr) {
            state.bike?.price = price
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
      
      case let action as SetupBasicsAction.ChangeCategory:
         state.bike?.category = action.category
         DBAccess.shared.save()
         
      case let action as SetupBasicsAction.ChangeIsElectrified:
         state.bike?.isElectrified = action.isElectro
         DBAccess.shared.save()
         
      case let action as SetupBasicsAction.ChangeRating:
         state.bike?.rating = action.rating
         DBAccess.shared.save()
         
      default: break
      }
      
      return state
   }
   
   static func updatePropertiesModel(_ state: inout SetupBasicsState)
   {
      guard let bike = state.bike else {
         assertionFailure("SetupBasicsState->updateBasicPropertiesModel: Can't create model because bike is nil")
         return
      }
      
      state.basicsModel = [
         PropertyModel(name: "NAME", label: bike.name, action: SetupBasicsAction.ChangeName()),
         PropertyModel(name: "BRAND", label: bike.brand, action: SetupBasicsAction.ChangeBrand()),
         PropertyModel(name: "MODEL YEAR", label: "\(bike.year)", action: SetupBasicsAction.ChangeModelYear()),
         PropertyModel(name: "SIZE", label: bike.size, action: SetupBasicsAction.ChangeSize()),
         PropertyModel(name: "WEIGHT", label: "\(bike.weight)", action: SetupBasicsAction.ChangeWeight()),
         PropertyModel(name: "PRICE", label: "\(bike.price)", action: SetupBasicsAction.ChangePrice()),
      ]
   }
}

