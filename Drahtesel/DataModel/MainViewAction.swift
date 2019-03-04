import ReSwift

struct MainViewAction
{
   struct OpenedPage: Action {
      let page: Page
   }
   
   struct PresentAlert: Action {
      let model: AlertViewModel
   }
   
   struct CloseAlert: Action {
   }
}
