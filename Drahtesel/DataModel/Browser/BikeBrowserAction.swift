import ReSwift

struct BikeBrowserAction
{
   struct OpenBike: Action {
      let bike: Bike
   }
   
   struct Select: Action {
      let bike: Bike
   }
   
   struct Deselect: Action {
      let bike: Bike
   }
   
   struct SetEdit: Action {
      let enabled: Bool
   }
   
   struct Add: Action, TextSetableAction {
      var text: String? = nil
   }
   
   struct Rename: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct Duplicate: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }

   struct CopySelectionTo: Action {
      let collection: Collection
   }
   
   struct Delete: Action, TextSetableAction {
      let bike: Bike
      var text: String? = nil
      init(bike: Bike) { self.bike = bike }
   }
   
   struct ChangeRating: Action {
      let bike: Bike
      let rating: Int
   }
   
   struct ChangeCompareEnabled: Action {
      let bike: Bike
      let enabled: Bool
   }
}
