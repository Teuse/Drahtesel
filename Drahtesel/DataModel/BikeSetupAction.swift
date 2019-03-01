import ReSwift

struct BikeSetupAction
{
   struct ChangeName: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeBrand: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeModelYear: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangePrice: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeCategory: Action {
      let bike: Bike
      let category: BikeCategory
   }
   
   struct ChangeIsElectrified: Action {
      let bike: Bike
      let isElectro: Bool
   }
   
   struct ChangeRating: Action {
      let bike: Bike
      let rating: Int
   }
   
   struct ChangeCompareEnabled: Action {
      let bike: Bike
      let enabled: Bool
   }
   
   struct ChangeColor: Action {
      let bike: Bike
      let color: ColorPalette
   }
   
   struct ChangeBBDrop: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeChainstay: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeHeadTubeAngle: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeReach: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeStack: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeSeatTube: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeSeatTubeAngle: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeTopTube: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeWheelbase: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
}
