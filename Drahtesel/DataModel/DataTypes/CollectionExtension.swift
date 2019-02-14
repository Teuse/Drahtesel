import Foundation

extension Collection
{
   func addBike(name: String) -> Bike
   {
      assert(managedObjectContext != nil, "Collection->addBike: managedObjectContext may not be nil.")
      if let context = managedObjectContext {
         let bike = Bike(context: context)
         addToBikeSet(bike)
         bike.id = UUID()
         bike.name = name
         bike.geometry = Geometry(context: context)
         bike.geometry?.id = UUID()
         bike.specification = Specification(context: context)
         bike.specification?.id = UUID()
         return bike
      }
      return Bike()
   }
   
   var bikes: [Bike] {
      let asArray = bikeSet?.allObjects as? [Bike]
      assert(asArray != nil, "Collection->bikesArray: bikes should never be nil. It should be an empty array instead")
      return asArray ?? [Bike]()
   }
   
   override public var description: String
   {
      let nameStr = name ?? "nil"
      let idStr = id?.uuidString ?? "nil"
      return "Collection(name=\"\(nameStr)\" id=\(idStr) bikes[\(bikes.count)]"
   }
   
   func copy(from collection: Collection)
   {
      name = collection.name
      typeRaw = collection.typeRaw
      
      for bike in collection.bikes {
         let new = addBike(name: bike.name!)
         new.copy(from: bike)
      }
   }
   
   func delete(bike: Bike)
   {
      assert(managedObjectContext != nil, "Collection->delete(bike): managedObjectContext may not be nil.")
      if let context = managedObjectContext {
         context.delete(bike.geometry!)
         context.delete(bike.specification!)
         context.delete(bike)
      }
   }
}
