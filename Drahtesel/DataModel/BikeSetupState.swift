import ReSwift

struct BikeSetupState: StateType
{
   var lastSetupPage: Page = .setupBasics
   var bike: Bike?
   
   var basicsModel = [PropertyModel]()
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
            updatePropertiesModel(&state)
         }
         if isSetupPage(action.page) {
            state.lastSetupPage = action.page
         }
         
      case let action as BikeAction.OpenBike:
         state.bike = action.bike
         
      case let action as BikeSetupAction.ChangeName:
         if let name = action.text {
            state.bike?.name = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
      
      case let action as BikeSetupAction.ChangeBrand:
         if let name = action.text {
            state.bike?.brand = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as BikeSetupAction.ChangeSize:
         if let name = action.text {
            state.bike?.size = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as BikeSetupAction.ChangeModelYear:
         if let yearStr = action.text, let year = Int(yearStr) {
            state.bike?.year = year
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as BikeSetupAction.ChangePrice:
         if let priceStr = action.text, let price = Double(priceStr) {
            state.bike?.price = price
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
      
      case let action as BikeSetupAction.ChangeCategory:
         state.bike?.category = action.category
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeIsElectrified:
         state.bike?.isElectrified = action.isElectro
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeRating:
         state.bike?.rating = action.rating
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeCompareEnabled:
         state.bike?.compareEnabled = action.enabled
         DBAccess.shared.save()
         
      case let action as BikeSetupAction.ChangeColor:
         state.bike?.color = action.color.uicolor
         DBAccess.shared.save()
         
      default: break
      }
      
      return state
   }
   
   static func isSetupPage(_ page: Page) -> Bool
   {
      return page == .setupBasics || page == .setupGeometry
          || page == .setupComparison || page == .setupSpecification
   }
   
   static func updatePropertiesModel(_ state: inout BikeSetupState)
   {
      guard let bike = state.bike else {
         assertionFailure("BikeSetupState->updateBasicPropertiesModel: Can't create model because bike is nil")
         return
      }
      
      state.basicsModel = [
         PropertyModel(name: "NAME", label: bike.name, action: BikeSetupAction.ChangeName()),
         PropertyModel(name: "BRAND", label: bike.brand, action: BikeSetupAction.ChangeBrand()),
         PropertyModel(name: "MODEL YEAR", label: "\(bike.year)", action: BikeSetupAction.ChangeModelYear()),
         PropertyModel(name: "SIZE", label: bike.size, action: BikeSetupAction.ChangeSize()),
         PropertyModel(name: "PRICE", label: "\(bike.price)", action: BikeSetupAction.ChangePrice()),
      ]
   }
}

