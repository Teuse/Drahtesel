import ReSwift

struct BikeSetupAction
{
   struct ChangeName: Action, TextSetableAction {
      var text: String? = nil
      init() {}
   }
   
   struct ChangeBrand: Action, TextSetableAction {
      var text: String? = nil
      init() {}
   }
   
   struct ChangeSize: Action, TextSetableAction {
      var text: String? = nil
      init() {}
   }
   
   struct ChangeModelYear: Action, TextSetableAction {
      var text: String? = nil
      init() {}
   }
   
   struct ChangePrice: Action, TextSetableAction {
      var text: String? = nil
      init() {}
   }
   
   struct ChangeCategory: Action {
      let category: BikeCategory
   }
   
   struct ChangeIsElectrified: Action {
      let isElectro: Bool
   }
   
   struct ChangeRating: Action {
      let rating: Int
   }
   
   struct ChangeCompareEnabled: Action {
      let enabled: Bool
   }
   
   struct ChangeColor: Action {
      let color: ColorPalette
   }
}
