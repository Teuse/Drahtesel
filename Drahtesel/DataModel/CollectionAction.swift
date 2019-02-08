import ReSwift

struct CollectionAction
{
   struct Select: Action {
      let collection: Collection
   }
   
   struct SetEdit: Action {
      let enabled: Bool
   }
}
