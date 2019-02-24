import ReSwift

struct BikeSetupAction
{
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
}
