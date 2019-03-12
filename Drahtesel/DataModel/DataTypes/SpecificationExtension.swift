import Foundation

extension Specification
{
   override public var description: String
   {
      return "Specification(...)"
   }
   
   func copy(from specification: Specification)
   {
      frame = specification.frame
      fork = specification.fork
      rearShock = specification.rearShock
      seatPost = specification.seatPost
      brakes = specification.brakes
      bottomBracket = specification.bottomBracket
      cranks = specification.cranks
      tyres = specification.tyres
      wheelset = specification.wheelset
      casette = specification.casette
      chainrings = specification.chainrings
      frontDerailleur = specification.frontDerailleur
      rearDerailleur = specification.rearDerailleur
   }
   
   //MARK: - String Wrapper
   
   var frame: String {
      get { return frameOpt ?? "" }
      set { frameOpt = newValue }
   }
   
   var fork: String {
      get { return forkOpt ?? "" }
      set { forkOpt = newValue }
   }
   
   var rearShock: String {
      get { return rearShockOpt ?? "" }
      set { rearShockOpt = newValue }
   }
   
   var seatPost: String {
      get { return seatPostOpt ?? "" }
      set { seatPostOpt = newValue }
   }
   
   //MARK: Misc
   
   var bottomBracket: String {
      get { return bottomBracketOpt ?? "" }
      set { bottomBracketOpt = newValue }
   }
   
   var brakes: String {
      get { return brakesOpt ?? "" }
      set { brakesOpt = newValue }
   }
   
   var cranks: String {
      get { return cranksOpt ?? "" }
      set { cranksOpt = newValue }
   }
   
   //MARK: Wheels
   
   var tyres: String {
      get { return tyresOpt ?? "" }
      set { tyresOpt = newValue }
   }
   
   var wheelset: String {
      get { return wheelsetOpt ?? "" }
      set { wheelsetOpt = newValue }
   }
   
   //MARK: Derailleur
   
   var casette: String {
      get { return casetteOpt ?? "" }
      set { casetteOpt = newValue }
   }
   
   var chainrings: String {
      get { return chainringsOpt ?? "" }
      set { chainringsOpt = newValue }
   }
   
   var frontDerailleur: String {
      get { return frontDerailleurOpt ?? "" }
      set { frontDerailleurOpt = newValue }
   }
   
   var rearDerailleur: String {
      get { return rearDerailleurOpt ?? "" }
      set { rearDerailleurOpt = newValue }
   }
}
