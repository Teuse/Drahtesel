import Foundation
import UIKit

extension Bike
{
   var name: String {
      get { return nameOpt ?? "" }
      set { nameOpt = newValue }
   }
   
   var brand: String {
      get { return brandOpt ?? "" }
      set { brandOpt = newValue }
   }
   
   var rating: Int {
      get { return Int(rating64) }
      set { year64 = Int64(newValue) }
   }
   
   var year: Int {
      get { return Int(year64) }
      set { rating64 = Int64(newValue) }
   }
   
   var paletteColor: ColorPalette {
      get {
         let uicolor = color as! UIColor
         return ColorPalette.convert(uicolor: uicolor) ?? .black
      }
      set { color = paletteColor.uicolor }
   }
   
   override public var description: String
   {
      let idStr = id?.uuidString ?? "nil"
      return "Bike(name=\"\(name)\" brand=\"\(brand)\" id=\(idStr)"
   }
   
   func copy(from bike: Bike)
   {
      name = bike.name
      brand = bike.brand
      categoryRaw = bike.categoryRaw
      color = bike.color
      compareEnabled = bike.compareEnabled
      year = bike.year
      isElectrified = bike.isElectrified
      rating = bike.rating
      
      assert(bike.geometry != nil, "Bike->copy(): Error, bike.geometry may not be nil")
      geometry?.copy(from: bike.geometry!)
      
      assert(bike.specification != nil, "Bike->copy(): Error, bike.specification may not be nil")
      specification?.copy(from: bike.specification!)
   }
}
