import CoreData
import Foundation

enum BikeCategory: Int64, CaseIterable {
   case race = 0
   case hardtail = 1
   case fully = 2
   case trekking = 3
   
   static let count = 4 // TODO: calculate automatically
   func description() -> String {
      switch self {
      case .race: return "Race"
      case .hardtail: return "Hardtail"
      case .fully: return "Fully"
      case .trekking: return "Trekking"
      }
   }
}

extension Bike {
   var category: BikeCategory {
      get { return BikeCategory(rawValue: categoryRaw) ?? .race }
      set { categoryRaw = newValue.rawValue }
   }
}
