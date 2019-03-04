import ReSwift

struct SetupComparisonAction
{
   struct ChangeCompareEnabled: Action {
      let enabled: Bool
   }
   
   struct ChangeColor: Action {
      let color: ColorPalette
   }
}
