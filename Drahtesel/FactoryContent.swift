import CoreData
import UIKit

class FactoryContent {
   let version = 1
   
   public func create()
   {
      trailBike2018()
      allMountainBike2018()
      xcBike2018()
      
      DBAccess.shared.save()
   }
   
   private func trailBike2018()
   {
      let collection = DBAccess.shared.addCollection(name: "Trail Bikes 2018")
      collection.type = .factory
      
      let vxspro = collection.addBike(name: "VXs Pro")
      vxspro.brand = "Votec"
      vxspro.size = "M"
      vxspro.color = ColorPalette.black.uicolor
      vxspro.compareEnabled = true
      let gvxspro = vxspro.geometry!
      vxspro.geometry = gvxspro
      gvxspro.reach = 433.0
      gvxspro.stack = 566.0
      gvxspro.topTube = 600.0
      gvxspro.seatTube = 440.0
      gvxspro.chainstay = 445.0
      gvxspro.wheelbase = 1152.0
      gvxspro.bbDrop = 43.0
      gvxspro.headTubeAngle = 68.7
      gvxspro.seatTubeAngle = 76.0
      vxspro.geometry = gvxspro
      
      let occam = collection.addBike(name: "Occam TR H10")
      occam.brand = "Orbea"
      occam.size = "M"
      occam.color = ColorPalette.steel.uicolor
      occam.compareEnabled = true
      let goccam = occam.geometry!
      goccam.reach = 431.0
      goccam.stack = 606.0
      goccam.topTube = 599.0
      goccam.seatTube = 432.0
      goccam.chainstay = 435.0
      goccam.wheelbase = 1150.0
      goccam.bbDrop = 33.0
      goccam.headTubeAngle = 67.5
      goccam.seatTubeAngle = 74.0
      occam.geometry = goccam
      
      let spark950 = collection.addBike(name: "Spark 950")
      spark950.brand = "Scott"
      spark950.size = "M"
      spark950.color = ColorPalette.nickel.uicolor
      spark950.compareEnabled = true
      let gspark950 = spark950.geometry!
      gspark950.reach = 432.7
      gspark950.stack = 593.1
      gspark950.topTube = 605.0
      gspark950.seatTube = 440.0
      gspark950.chainstay = 438.0
      gspark950.wheelbase = 1151.6
      gspark950.bbDrop = 43.0
      gspark950.headTubeAngle = 67.2
      gspark950.seatTubeAngle = 73.8
      spark950.geometry = gspark950
      
      let jeffsy = collection.addBike(name: "Jeffsy 29")
      jeffsy.brand = "YT"
      jeffsy.size = "M"
      jeffsy.color = ColorPalette.mercury.uicolor
      jeffsy.compareEnabled = false
      let gjeffsy = jeffsy.geometry!
      gjeffsy.reach = 425.0
      gjeffsy.stack = 610.0
      gjeffsy.topTube = 592.0
      gjeffsy.seatTube = 440.0
      gjeffsy.chainstay = 435.5
      gjeffsy.wheelbase = 1154.0
      gjeffsy.bbDrop = 24.0
      gjeffsy.headTubeAngle = 67.5
      gjeffsy.seatTubeAngle = 75.0
      jeffsy.geometry = gjeffsy
      
      let skeen = collection.addBike(name: "Skeen Trail")
      skeen.brand = "Radon"
      skeen.size = "18\""
      skeen.color = ColorPalette.cayenne.uicolor
      skeen.compareEnabled = false
      let gskeen = skeen.geometry!
      gskeen.reach = 436.0
      gskeen.stack = 610.0
      gskeen.topTube = 594.0
      gskeen.seatTube = 450.0
      gskeen.chainstay = 448.0
      gskeen.wheelbase = 1170.0
      gskeen.bbDrop = 38.0
      gskeen.headTubeAngle = 68.0
      gskeen.seatTubeAngle = 75.0
      skeen.geometry = gskeen
      
      let stereo = collection.addBike(name: "Stereo 140 HPC")
      stereo.brand = "Cube"
      stereo.size = "18\""
      stereo.color = ColorPalette.red.uicolor
      stereo.compareEnabled = false
      let gstereo = stereo.geometry!
      gstereo.reach = 438.0
      gstereo.stack = 601.0
      gstereo.topTube = 591.0
      gstereo.seatTube = 420.0
      gstereo.chainstay = 425.0
      gstereo.wheelbase = 1165.0
      gstereo.bbDrop = 16.0
      gstereo.headTubeAngle = 66.5
      gstereo.seatTubeAngle = 75.2
      stereo.geometry = gstereo
      
      let neuron = collection.addBike(name: "Neuron M")
      neuron.brand = "Canyon"
      neuron.size = "M"
      neuron.color = ColorPalette.orange.uicolor
      neuron.compareEnabled = false
      let gneuron = neuron.geometry!
      gneuron.reach = 426.0
      gneuron.stack = 598.0
      gneuron.topTube = 599.0
      gneuron.seatTube = 440.0
      gneuron.chainstay = 445.0
      gneuron.wheelbase = 1136.0
      gneuron.bbDrop = 27.0
      gneuron.headTubeAngle = 69.3
      gneuron.seatTubeAngle = 73.8
      neuron.geometry = gneuron
      
      let camber = collection.addBike(name: "Camber Comp 29")
      camber.brand = "Specialized"
      camber.size = "M"
      camber.color = ColorPalette.yellow.uicolor
      camber.compareEnabled = false
      let gcamber = camber.geometry!
      gcamber.reach = 427.0
      gcamber.stack = 609.0
      gcamber.topTube = 590.0
      gcamber.seatTube = 395.0
      gcamber.chainstay = 437.0
      gcamber.wheelbase = 1135.0
      gcamber.bbDrop = 42.9
      gcamber.headTubeAngle = 68.5
      gcamber.seatTubeAngle = 75.0
      camber.geometry = gcamber
   }
   
   private func allMountainBike2018() {
      let collection = DBAccess.shared.addCollection(name: "All Mountain Bikes 2018")
      collection.type = .factory
      
      let vxpro = collection.addBike(name: "VX Pro")
      vxpro.brand = "Votec"
      vxpro.size = "M"
      vxpro.color = ColorPalette.yellow.uicolor
      vxpro.compareEnabled = false
      let gvxpro = vxpro.geometry!
      gvxpro.reach = 423.0
      gvxpro.stack = 619.0
      gvxpro.topTube = 586.0
      gvxpro.seatTube = 440.0
      gvxpro.chainstay = 445.0
      gvxpro.wheelbase = 1160.0
      gvxpro.bbDrop = 36.0
      gvxpro.headTubeAngle = 67.8
      gvxpro.seatTubeAngle = 75.1
      vxpro.geometry = gvxpro
      
      let slide = collection.addBike(name: "Slide 140")
      slide.brand = "Radon"
      slide.size = "18\""
      slide.color = ColorPalette.honey.uicolor
      slide.compareEnabled = false
      let gslide = slide.geometry!
      gslide.reach = 434.0
      gslide.stack = 598.0
      gslide.topTube = 596.0
      gslide.seatTube = 440.0
      gslide.chainstay = 435.5
      gslide.wheelbase = 1158.0
      gslide.bbDrop = 14.0
      gslide.headTubeAngle = 67.5
      gslide.seatTubeAngle = 74.2
      slide.geometry = gslide
      
      let stumpjumper = collection.addBike(name: "Stumpjumper")
      stumpjumper.brand = "Specialized"
      stumpjumper.size = "M"
      stumpjumper.color = ColorPalette.honey.uicolor
      stumpjumper.compareEnabled = false
      let gstumpjumper = stumpjumper.geometry!
      gstumpjumper.reach = 414.0
      gstumpjumper.stack = 599.0
      gstumpjumper.topTube = 585.0
      gstumpjumper.seatTube = 395.0
      gstumpjumper.chainstay = 420.0
      gstumpjumper.wheelbase = 1126.0
      gstumpjumper.bbDrop = 18.9
      gstumpjumper.headTubeAngle = 67.0
      gstumpjumper.seatTubeAngle = 74.0
      stumpjumper.geometry = gstumpjumper
   }
   
   private func xcBike2018() {
      let collection = DBAccess.shared.addCollection(name: "XC Bikes 2018")
      collection.type = .factory
      
      let lux = collection.addBike(name: "Lux CF")
      lux.brand = "Canyon"
      lux.size = "M"
      lux.color = ColorPalette.spring.uicolor
      lux.compareEnabled = false
      let glux = lux.geometry!
      glux.reach = 393.0
      glux.stack = 582.0
      glux.topTube = 560.0
      glux.seatTube = 395.0
      glux.chainstay = 450.0
      glux.wheelbase = 1087.0
      glux.bbDrop = 40.0
      glux.headTubeAngle = 70.0
      glux.seatTubeAngle = 74.0
      lux.geometry = glux
      
      let epic = collection.addBike(name: "Epic")
      epic.brand = "Specialized"
      epic.size = "M"
      epic.color = ColorPalette.green.uicolor
      epic.compareEnabled = false
      let gepic = epic.geometry!
      gepic.reach = 433.0
      gepic.stack = 602.0
      gepic.topTube = 597.0
      gepic.seatTube = 395.0
      gepic.chainstay = 438.7
      gepic.wheelbase = 1125.0
      gepic.bbDrop = 38.9
      gepic.headTubeAngle = 69.5
      gepic.seatTubeAngle = 74.75
      epic.geometry = gepic  
   }
}
