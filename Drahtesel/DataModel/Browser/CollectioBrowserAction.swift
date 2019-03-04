import ReSwift

struct CollectioBrowserAction
{
   struct Select: Action {
      let collection: Collection
   }
   
   struct SetEdit: Action {
      let enabled: Bool
   }
   
   struct Add: Action, TextSetableAction {
      var text: String? = nil
   }
   
   struct Rename: Action, TextSetableAction {
      let collection: Collection
      var text: String? = nil
      init(collection: Collection) { self.collection = collection }
   }
   
   struct Duplicate: Action, TextSetableAction {
      let collection: Collection
      var text: String? = nil
      init(collection: Collection) { self.collection = collection }
   }
   
   struct Delete: Action, TextSetableAction {
      let collection: Collection
      var text: String? = nil
      init(collection: Collection) { self.collection = collection }
   }
}
