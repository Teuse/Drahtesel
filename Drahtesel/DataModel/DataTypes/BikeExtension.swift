import Foundation

extension Bike
{
   override public var description: String
   {
      let nameStr = name ?? "nil"
      let brandStr = brand ?? "nil"
      let idStr = id?.uuidString ?? "nil"
      return "Bike(name=\"\(nameStr)\" brand=\"\(brandStr)\" id=\(idStr)"
   }
}
