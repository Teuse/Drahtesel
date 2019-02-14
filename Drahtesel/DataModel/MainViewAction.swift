import ReSwift

struct MainViewAction
{
   struct OpenedPage: Action {
      let page: Pages
   }
   
   struct PresentAlert: Action {
      let model: AlertViewModel
   }
   
   struct CloseAlert: Action {
   }
}
