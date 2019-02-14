import ReSwift

struct CollectionAction
{
   struct Select: Action {
      let collection: Collection
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
      let collection: Collection
      private(set) var name: String
      
      mutating func setAlertText(_ text: String) {
         name = text
      }
   }
   
   struct Duplicate: Action, AlertableAction {
      let collection: Collection
      private(set) var name: String
      
      mutating func setAlertText(_ text: String) {
         name = text
      }
   }
   
   struct Delete: Action, AlertableAction {
      let collection: Collection
      
      func setAlertText(_ text: String) {}
   }
}
