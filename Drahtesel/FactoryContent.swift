import CoreData
import Foundation

class FactoryContent {
   let version = 1
   
   public func create()
   {
      trailBike2018()
      allMountainBike2018()
      xcBike2018()
   }
   
   private func trailBike2018()
   {
      let collection = DBAccess.shared.addCollection(name: "Trail Bikes 2018")
      collection.type = .factory
      
      let vxspro = collection.addBike(name: "VXs Pro M")
      vxspro.brand = "Votec"
      vxspro.color = 0
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
      
      let occam = collection.addBike(name: "Occam TR H10 M")
      occam.brand = "Orbea"
      occam.color = 1
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
      spark950.color = 2
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
      
      let jeffsy = collection.addBike(name: "Jeffsy 29 M")
      jeffsy.brand = "YT"
      jeffsy.color = 3
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
      
      let skeen = collection.addBike(name: "Skeen Trail 18\"")
      skeen.brand = "Radon"
      skeen.color = 4
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
      
      let stereo = collection.addBike(name: "Stereo 140 HPC 18\"")
      stereo.brand = "Cube"
      stereo.color = 5
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
      neuron.color = 6
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
      
      let camber = collection.addBike(name: "Camber Comp 29 M")
      camber.brand = "Specialized"
      camber.color = 7
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
      
      let vxpro = collection.addBike(name: "VX Pro M")
      vxpro.brand = "Votec"
      vxpro.color = 8
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
      
      let slide = collection.addBike(name: "Slide 140 18\"")
      slide.brand = "Radon"
      slide.color = 9
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
      
      let stumpjumper = collection.addBike(name: "Stumpjumper M")
      stumpjumper.brand = "Specialized"
      stumpjumper.color = 10
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
      
      let lux = collection.addBike(name: "Lux CF M")
      lux.brand = "Canyon"
      lux.color = 11
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
      
      let epic = collection.addBike(name: "Epic M")
      epic.brand = "Specialized"
      epic.color = 12
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
