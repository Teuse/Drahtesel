import UIKit
import ReSwift

class CompareGeometryViewController: UIViewController, EmbeddedController
{
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var zoomView: UIView!
   var centerSelectorControl: UISegmentedControl!
   var bikeImages: [UIImageView] = []
   
   private var xPixelConvertionFactor: CGFloat!
   
   //MARK: - Life Circle
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      
      let height = CGFloat(self.view.frame.size.height)
      self.xPixelConvertionFactor = height * 0.001
      
      self.scrollView.delegate = self
      self.scrollView.minimumZoomScale = 1
      self.scrollView.maximumZoomScale = 3.0
      
      let tabGesture = UITapGestureRecognizer(target: self, action: #selector(CompareGeometryViewController.doubleTap(recognizer:)))
      tabGesture.numberOfTapsRequired = 2
      self.view.addGestureRecognizer(tabGesture)
   }
   
   func embeddedViewWillShow(_ animated: Bool)
   {
      subscribe(self)
      dispatch(action: MainViewAction.OpenedPage(page: .compareGeometry))
   }
   
   func embeddedViewWillHide(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   //MARK: Actions
   
   @objc func doubleTap(recognizer: UITapGestureRecognizer)
   {
      self.scrollView.setZoomScale(1.0, animated: true)
   }
}

// --------------------------------------------------------------------------------
//MARK: - Bike Images Construction/Destruction

extension CompareGeometryViewController
{
   private func createBikeImages(forBikes bikes: [Bike])
   {
      for bike in bikes {
         if bike.compareEnabled {
            self.addImage(for: bike)
         }
      }
   }
   
   private func addImage(for bike: Bike)
   {
      let img = UIImageView(frame: self.zoomView.frame)
      img.alpha = 0.6
      drawBike(bike, on: img, withColor: bike.color as! UIColor)
      
      self.zoomView.addSubview(img)
      self.bikeImages.append(img)
   }
   
   private func removeBikeImages()
   {
      for img in bikeImages {
         img.removeFromSuperview()
      }
      bikeImages.removeAll()
   }
   
   private func drawBike(_ bike: Bike, on imageView: UIImageView, withColor color: UIColor)
   {
      UIGraphicsBeginImageContext(imageView.frame.size)
      guard let context = UIGraphicsGetCurrentContext() else {
         assertionFailure("CompareTab: Failed to get UIGraphicsGetCurrentContext")
         return
      }
      
      let bc = BikeCoordinates(withBike: bike)
//      switch self.centerSelectorControl.selectedSegmentIndex {
//      case 0: bc.bikeCenter = BikeCoordinates.BikeCenter.bottom_bracket
//      case 1: bc.bikeCenter = BikeCoordinates.BikeCenter.bottom_bracket_wheel_base
//      case 2: bc.bikeCenter = BikeCoordinates.BikeCenter.wheels_on_ground
//      default: assertionFailure("Error: Not all segments implemented!")
//      }
      
      context.move(to:    toPx(bc.bottomBracket))
      context.addLine(to: toPx(bc.rearAxel))
      context.addLine(to: toPx(bc.toptubeBack))
      context.addLine(to: toPx(bc.forkTop))
      
      context.move(to:    toPx(bc.bottomBracket))
      context.addLine(to: toPx(bc.seattubeTop))
      
      context.move(to:    toPx(bc.bottomBracket))
      context.addLine(to: toPx(bc.forkTop))
      
      context.addLine(to: toPx(bc.forkBottom))
      context.addLine(to: toPx(bc.frontAxel))
      
      let color = bike.color as! UIColor
      context.setStrokeColor(color.cgColor)

//      context.setStrokeColor(
//         red:  CGFloat(color.red),  green: CGFloat(color.green),
//         blue: CGFloat(color.blue), alpha: CGFloat(color.alpha))
      context.setLineCap(.square)
      context.setLineWidth(4.0)
      context.setBlendMode(.normal)
      
      context.strokePath()
      
      imageView.image = UIGraphicsGetImageFromCurrentImageContext()
      imageView.alpha = 1
      UIGraphicsEndImageContext()
   }
   
   //----------------------------------------------------------------------------------------
   //MARK: - Helper Funcions
   
   private func toPx(_ point: CGPoint) -> CGPoint
   {
      let pointX = point.x * xPixelConvertionFactor
      let pointY = view.frame.height - point.y * xPixelConvertionFactor
      return CGPoint(
         x: pointX + view.frame.width/2.0,
         y: pointY - view.frame.height*0.25)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ScrollViewDelegate

extension CompareGeometryViewController: UIScrollViewDelegate
{
   func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return zoomView
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension CompareGeometryViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
      guard let collection = state.bikeBrowserState.collection else { return }
      
      removeBikeImages()
      createBikeImages(forBikes: collection.bikes)
   }
}

