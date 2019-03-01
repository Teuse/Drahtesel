import CoreData
import Foundation

class DBAccess
{
   static let shared = DBAccess()
   
   private var persistentContainer: NSPersistentContainer = {
         return getPersistentContainer()
   }()
   
   private var context: NSManagedObjectContext {
      return persistentContainer.viewContext
   }
   
   //MARK: - Life Circle
   // -----------------------------------------------------------------------------
   
   private init() {}
   
   func save() {
      guard context.hasChanges else { return }
      
      do {
         try context.save()
      } catch {
         let nserror = error as NSError
         print("DBAccess->save(): Unresolved error \(nserror), \(nserror.userInfo)")
         assertionFailure()
      }
   }
}

//MARK: - Collections
// -----------------------------------------------------------------------------
extension DBAccess
{
   func addCollection(name: String) -> Collection {
      let collection = Collection(context: context)
      collection.id = UUID()
      collection.name = name
      return collection
   }
   
   func collections(withType type: CollectionType? = nil) -> [Collection] {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: DB.Entity.collection)
      
      if let type = type {
         let predicate = NSPredicate(format: "typeRaw = %i", type.rawValue)
         request.predicate = predicate
      }
      
      let sort = NSSortDescriptor(key: "nameOpt", ascending: false)
      request.sortDescriptors = [sort]
      
      do {
         return try context.fetch(request) as! [Collection]
      } catch {
         fatalError("Failed to fetch Groups: \(error)")
      }
   }
   
   func delete(collection: Collection)
   {
      for bike in collection.bikes {
         collection.delete(bike: bike)
      }
      context.delete(collection)
   }
}

// Mark - Load
// --------------------------------------------------------------------------------
extension DBAccess
{
   private static func getPersistentContainer() -> NSPersistentContainer {
      let container = NSPersistentContainer(name: "Drahtesel")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      })
      return container
   }
}
