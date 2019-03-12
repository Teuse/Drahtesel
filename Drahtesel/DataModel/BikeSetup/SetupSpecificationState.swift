import ReSwift

struct SetupSpecificationState: StateType
{
   var bike: Bike?
   
   var model1 = [PropertyModel]()
   var model2 = [PropertyModel]()
   var model3 = [PropertyModel]()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension SetupSpecificationState
{
   static func reducer(action: Action, state: SetupSpecificationState?) -> SetupSpecificationState {
      var state = state ?? SetupSpecificationState()
      
      switch action
      {
      case let action as MainViewAction.OpenedPage:
         if action.page == .setupSpecification {
            updatePropertiesModel(&state)
         }
         
      case let action as BikeBrowserAction.OpenBike:
         state.bike = action.bike
         
      case let action as SetupSpecificationAction.ChangeFrame:
         if let name = action.text {
            state.bike?.specification?.frame = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeFork:
         if let name = action.text {
            state.bike?.specification?.fork = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeRearShok:
         if let name = action.text {
            state.bike?.specification?.rearShock = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeSeatPost:
         if let name = action.text {
            state.bike?.specification?.seatPost = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeBrakes:
         if let name = action.text {
            state.bike?.specification?.brakes = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeBottomBracket:
         if let name = action.text {
            state.bike?.specification?.bottomBracket = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeCranks:
         if let name = action.text {
            state.bike?.specification?.cranks = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeTyres:
         if let name = action.text {
            state.bike?.specification?.tyres = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeWheelset:
         if let name = action.text {
            state.bike?.specification?.wheelset = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeCasette:
         if let name = action.text {
            state.bike?.specification?.casette = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeFrontDerailleur:
         if let name = action.text {
            state.bike?.specification?.frontDerailleur = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      case let action as SetupSpecificationAction.ChangeRearDerailleur:
         if let name = action.text {
            state.bike?.specification?.rearDerailleur = name
            DBAccess.shared.save()
            updatePropertiesModel(&state)
         }
         
      default: break
      }
      
      return state
   }
   
   static func updatePropertiesModel(_ state: inout SetupSpecificationState)
   {
      guard let bike = state.bike, let spec = bike.specification else {
         assertionFailure("BikeSetupState->updateGeometryPropertiesModel: Can't create model because bike/geometry is nil")
         return
      }

      state.model1 = [
         PropertyModel(name: "FRAME", label: spec.frame, action: SetupSpecificationAction.ChangeFrame()),
         PropertyModel(name: "FORK", label: spec.fork, action: SetupSpecificationAction.ChangeFork()),
         PropertyModel(name: "REAR SHOCK", label: spec.rearShock, action: SetupSpecificationAction.ChangeRearShok()),
         PropertyModel(name: "SEAT POST", label: spec.seatPost, action: SetupSpecificationAction.ChangeSeatPost()),
         PropertyModel(name: "BRAKS", label: spec.brakes, action: SetupSpecificationAction.ChangeBrakes()),
      ]
      
      state.model2 = [
         PropertyModel(name: "BOTTOM BRACKET", label: spec.bottomBracket, action: SetupSpecificationAction.ChangeBottomBracket()),
         PropertyModel(name: "CRANKS", label: spec.cranks, action: SetupSpecificationAction.ChangeCranks()),
         PropertyModel(name: "TYRES", label: spec.tyres, action: SetupSpecificationAction.ChangeTyres()),
         PropertyModel(name: "WHEELSET", label: spec.wheelset, action: SetupSpecificationAction.ChangeWheelset()),
      ]
      
      state.model3 = [
         PropertyModel(name: "FRONT DERAILLEUR", label: spec.frontDerailleur, action: SetupSpecificationAction.ChangeFrontDerailleur()),
         PropertyModel(name: "FRONT DERAILLEUR", label: spec.rearDerailleur, action: SetupSpecificationAction.ChangeRearDerailleur()),
         PropertyModel(name: "CHAINRING", label: spec.chainrings, action: SetupSpecificationAction.ChangeChainring()),
         PropertyModel(name: "CASETTE", label: spec.casette, action: SetupSpecificationAction.ChangeCasette()),
      ]
   }
}

