import Foundation

protocol Numeric : Codable, Comparable
{
   static func +(lhs: Self, rhs: Self) -> Self
   static func -(lhs: Self, rhs: Self) -> Self
   static func *(lhs: Self, rhs: Self) -> Self
   static func /(lhs: Self, rhs: Self) -> Self
   //static func %(lhs: Self, rhs: Self) -> Self
   
   init(_ v: Double)
   init(_ v: Float)
   init(_ v: Int)
   init(_ v: Int8)
   init(_ v: Int16)
   init(_ v: Int32)
   init(_ v: Int64)
   init(_ v: UInt8)
   init(_ v: UInt16)
   init(_ v: UInt32)
   init(_ v: UInt64)
}

extension Double  : Numeric { }
extension Float   : Numeric { }
extension Int     : Numeric { }
extension Int8    : Numeric { }
extension Int16   : Numeric { }
extension Int32   : Numeric { }
extension Int64   : Numeric { }
extension UInt    : Numeric { }
extension UInt8   : Numeric { }
extension UInt16  : Numeric { }
extension UInt32  : Numeric { }
extension UInt64  : Numeric { }
