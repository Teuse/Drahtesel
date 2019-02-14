import Foundation

extension Specification
{
   override public var description: String
   {
      return "Specification(...)"
   }
   
   func copy(from specification: Specification)
   {
      fork = specification.fork
      rearShock = specification.rearShock
   }
}
