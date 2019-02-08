import CoreData
import Foundation

enum CollectionType: Int64, CaseIterable {
   case user = 0
   case factory = 1
   
   func description() -> String {
      switch self {
      case .factory: return "Factory Collections"
      case .user: return "User Collections"
      }
   }
}

extension Collection {
   var type: CollectionType {
      get { return CollectionType(rawValue: typeRaw) ?? .user }
      set { typeRaw = newValue.rawValue }
   }
}

