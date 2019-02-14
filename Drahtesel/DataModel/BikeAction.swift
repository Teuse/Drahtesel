import ReSwift

struct BikeAction
{
   struct Select: Action {
      let bike: Bike
   }
   
   struct SetEdit: Action {
      let enabled: Bool
   }
   
   struct Add: Action, AlertableAction {
      private(set) var name: String
      
      mutating func setAlertText(_ text: String) {
         name = text
      }
   }
   
   struct Rename: Action, AlertableAction {
      let bike: Bike
      private(set) var name: String
      
      mutating func setAlertText(_ text: String) {
         name = text
      }
   }
   
   struct Duplicate: Action, AlertableAction {
      let bike: Bike
      private(set) var name: String
      
      mutating func setAlertText(_ text: String) {
         name = text
      }
   }
   
   struct Delete: Action, AlertableAction {
      let bike: Bike
      
      func setAlertText(_ text: String) {}
   }
}
