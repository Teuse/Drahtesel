import Foundation

extension Specification
{
   var fork: String {
      get { return forkOpt ?? "" }
      set { forkOpt = newValue }
   }
   
   var rearShock: String {
      get { return rearShockOpt ?? "" }
      set { rearShockOpt = newValue }
   }
   
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
