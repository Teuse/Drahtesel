import UIKit

enum ColorPalette: Int, CaseIterable
{
   case black, steel, nickel, mercury
   case cayenne, red, orange, yellow
   case honey, spring, green, midnight
   case purple, blue, magenta, pink
   
   static func convert(uicolor: UIColor) -> ColorPalette?
   {
      let colors = ColorPalette.allCases
      let idx = colors.firstIndex{ return $0.uicolor == uicolor }
      return idx == nil ? nil : colors[idx!]
   }
   
   var description: String {
      switch self {
      case .black: return "Black"
      case .steel: return "Steel"
      case .nickel: return "Nickel"
      case .mercury: return "Mercury"
         
      case .cayenne: return "Cayenne"
      case .red: return "Red"
      case .orange: return "Orange"
      case .yellow: return "Yellow"
         
      case .honey: return "Honey"
      case .spring: return "Spring"
      case .green: return "Green"
      case .midnight: return "Midnight"
         
      case .purple: return "Purple"
      case .blue: return "Blue"
      case .magenta: return "Magenta"
      case .pink: return "Pink"
      }
   }
   
   var uicolor: UIColor {
      switch self {
      case .black: return UIColor(white: 0, alpha: 1)
      case .steel: return UIColor(white: 0.333, alpha: 1)
      case .nickel: return UIColor(white: 0.574, alpha: 1)
      case .mercury: return UIColor(white: 0.921, alpha: 1)
       
      case .cayenne: return UIColor(red: 148/255, green: 17/255, blue: 0, alpha: 1)
      case .red: return UIColor(red: 255/255, green: 38/255, blue: 0, alpha: 1)
      case .orange: return UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
      case .yellow: return UIColor(red: 255/255, green: 251/255, blue: 0, alpha: 1)
         
      case .honey: return UIColor(red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
      case .spring: return UIColor(red: 0, green: 249/255, blue: 0, alpha: 1)
      case .green: return UIColor(red: 79/255, green: 143/255, blue: 0, alpha: 1)
      case .midnight: return UIColor(red: 1/255, green: 25/255, blue: 147/255, alpha: 1)
         
      case .purple: return UIColor(red: 148/255, green: 33/255, blue: 147/255, alpha: 1)
      case .blue: return UIColor(red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
      case .magenta: return UIColor(red: 155/255, green: 64/255, blue: 255/255, alpha: 1)
      case .pink: return UIColor(red: 255/255, green: 47/255, blue: 146/255, alpha: 1)
      }
   }
}
