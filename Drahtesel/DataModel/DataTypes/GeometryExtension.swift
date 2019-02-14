import Foundation

extension Geometry
{
   override public var description: String
   {
      return "Geometry(...)"
   }
   
   func copy(from geometry: Geometry)
   {
      reach = geometry.reach
      stack = geometry.stack
      bbDrop = geometry.bbDrop
      chainstay = geometry.chainstay
      headTubeAngle = geometry.headTubeAngle
      seatTube = geometry.seatTube
      seatTubeAngle = geometry.seatTubeAngle
      topTube = geometry.topTube
      wheelbase = geometry.wheelbase
      wheelSize = geometry.wheelSize
   }
}
