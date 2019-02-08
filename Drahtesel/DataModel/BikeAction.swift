import ReSwift

struct BikeAction
{
   struct Select: Action {
      let bike: Bike
   }
   
   struct SetEdit: Action {
      let enabled: Bool
   }
}
