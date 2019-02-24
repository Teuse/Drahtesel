import UIKit

enum Storyboard
{
   static func create<T: UIViewController>(name: String) -> T
   {
      let sb = UIStoryboard(name: name, bundle: nil)
      let vc = sb.instantiateInitialViewController() as? T
      assert(vc != nil, "Failed to initialize ViewController from Storyboard with name \(name)")
      return vc!
   }
}
