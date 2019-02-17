import Foundation
import UIKit
import CoreData

class BikeCoordinates
{
   var bottomBracket : CGPoint {
      get { return calculateBottomBracket() }
   }
   
   var rearAxel : CGPoint {
      get { return calculateRearAxel() }
   }
   
   var frontAxel : CGPoint {
      get { return calculateFrontAxel() }
   }
   
   var forkTop : CGPoint {
      get { return calculateForkTop() }
   }
   
   var forkBottom : CGPoint {
      get { return calculateForkBottom() }
   }
   
   var seattubeTop : CGPoint {
      get { return calculateSeattubeTop() }
   }
   
   var toptubeBack : CGPoint {
      get { return calculateToptubeBack() }
   }
   
   var bikeCenter : BikeCenter = BikeCenter.bottom_bracket
   
   //------------------------------------------------------------------------------------
   
   private let bike: Bike
   
   private var geometry: Geometry {
      return bike.geometry!
   }
   
   init(withBike bike: Bike) {
      self.bike = bike
   }
   
   enum BikeCenter : Int {
      case bottom_bracket, bottom_bracket_wheel_base, wheels_on_ground
      
      static let count = 3
      func description() -> String
      {
         switch self {
         case .bottom_bracket:            return "Bottom Bracket"
         case .bottom_bracket_wheel_base: return "Wheelbase"
         case .wheels_on_ground:          return "Wheels on Ground"
         }
      }
   }
}

//----------------------------------------------------------------------------------------
//MARK: - Calculation Functions

extension BikeCoordinates
{
   //------------------------------------------------------------------------------------
   // NOTE:
   // The center of the bike in the coordinate system P(0,0) is the intersection
   // of a horizontal line across the front/rear axel and the vertical line across
   // the bottom bracket
   
   private func calculateBottomBracket()-> CGPoint
   {
      if bikeCenter == BikeCenter.bottom_bracket_wheel_base {
         return CGPoint(x: 0, y: -geometry.bbDrop)
      }
      return CGPoint(x: 0, y: 0)
   }
   
   private func calculateRearAxel() -> CGPoint
   {
      if bikeCenter == BikeCenter.bottom_bracket_wheel_base {
         return CGPoint(x: -self.horizontalLengthChainstay, y: 0)
      }
      return CGPoint(x: -self.horizontalLengthChainstay, y: geometry.bbDrop)
   }
   
   private func calculateFrontAxel() -> CGPoint
   {
      let yPos = bikeCenter == BikeCenter.bottom_bracket_wheel_base
         ? 0 : geometry.bbDrop
      let xLength = geometry.wheelbase - self.horizontalLengthChainstay
      return CGPoint(x: xLength, y: yPos)
   }
   
   private func calculateForkTop() -> CGPoint
   {
      let yLength = bikeCenter == BikeCenter.bottom_bracket_wheel_base
         ? geometry.stack-geometry.bbDrop : geometry.stack
      return CGPoint(x: geometry.reach, y: yLength)
   }
   
   private func calculateForkBottom() -> CGPoint
   {
      let yPos = bikeCenter == BikeCenter.bottom_bracket_wheel_base ? 0 : geometry.bbDrop
      let forkHeight = geometry.stack - geometry.bbDrop
      let forkWidth  = forkHeight / tan( radiants(fromAngle: geometry.headTubeAngle) )
      
      return CGPoint(x: geometry.reach + forkWidth, y: yPos)
   }
   
   private func calculateSeattubeTop() -> CGPoint
   {
      let xPos = -self.horizontalLengthSeattube(for: geometry.seatTube)
      var yPos = self.verticalLengthSeattube(for: geometry.seatTube)
      if bikeCenter == BikeCenter.bottom_bracket_wheel_base {
         yPos -= geometry.bbDrop
      }
      return CGPoint(x: xPos, y: yPos)
   }
   
   private func calculateToptubeBack() -> CGPoint
   {
      let factor = bike.category == BikeCategory.fully ? 0.6666 : 0.9
      let xPos = -self.horizontalLengthSeattube(for: geometry.seatTube * factor)
      var yPos = self.verticalLengthSeattube(for: geometry.seatTube * factor)
      if bikeCenter == BikeCenter.bottom_bracket_wheel_base {
         yPos -= geometry.bbDrop
      }
      return CGPoint(x: xPos, y: yPos)
   }

}

//----------------------------------------------------------------------------------------
//MARK: - Helper functions

extension BikeCoordinates
{
   private var horizontalLengthChainstay : Double {
      get { return sqrt( pow(geometry.chainstay,2) - pow(geometry.bbDrop,2) ) }
   }
   
   private func horizontalLengthSeattube(for seattube: Double) -> Double {
      return seattube * cos( radiants(fromAngle: geometry.seatTubeAngle))
   }
   
   private func verticalLengthSeattube(for seattube: Double) -> Double {
      return seattube * sin( radiants(fromAngle: geometry.seatTubeAngle))
   }

   private func radiants(fromAngle angle: Double) -> Double {
      return angle * Double.pi / 180.0
   }
}

