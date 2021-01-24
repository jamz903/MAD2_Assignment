//
//  CanteenViewController.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 24/1/21.
//

import Foundation
import UIKit

class CanteenViewController:UIViewController{
    
    var CanteenList: [Canteen] = [Canteen]()
    
    var newCanteen = [String: Any]()
    
    var value = ""
    
    let urls = ["https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2073%3ELevel%201%3EMunch",
        
        "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2051%3ELevel%202%20-%20Canteen%3ECoverageArea-B51L02",
    
    "https://www1.np.edu.sg/npnet/wifiatcanteen/CMXService.asmx/getChartData?Location=System%20Campus%3EBlk%2022%3ELevel%201%3ECoverageArea-B22L01" ]
    
    
    let trackLayer = CAShapeLayer()
    
    var munchLabel: UILabel? = nil
    
    override func viewDidLoad() {
        
        for i in urls{
            loadDataXML(from: i)
            //newCanteen = convertToDictionary(text: value) ?? ["value": 2, "color": "wrong","label":"wrong"]
        }
        print("done")
        super.viewDidLoad()
        
        for i in CanteenList{
            makecircle(x: i)
        }
        
    }
    
    
   
    var circlecount = 0
    
    
    private func makecircle(x :Canteen){
        print("circl")
        var pos = CGPoint(x: 200, y: 200)

        for i in 0..<(CanteenList.count){
            if i == 0{
                pos = CGPoint(x: 200, y: 200)
                circlecount += 1
            }
            else if i == 1{
                pos = CGPoint(x: 200, y: 415)
                circlecount += 1
            }
            else if i == 2{
                pos = CGPoint(x: 200, y: 630)
                circlecount += 1
            }

        }



        //track layer
        let trackLayer = CAShapeLayer()
        let shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: pos, radius: 100, startAngle: -CGFloat.pi/2 , endAngle: 2 * CGFloat.pi, clockwise: true)
        //let circularPath = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 100, height: 100))
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        //load layer with the colour thing ynoe
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        //shapeLayer.strokeStart = 0.75
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.7//change this to change how much it moves
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basic animation")
    }
    
    //add numbers
//    @objc func handleUpdate(){
//        print("123")
//
//        self.munchLabel!.text = "\(start)"
//        start += 1
//
//        if start > 100{
//            start = 100
//        }
//    }
    
    private func loadDataXML(from url: String){
        let url = url
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared.dataTask(with: request){
            (data, _, error) in
            
            if error != nil{
                //
                print("error")
                return
            }
            guard let data = data else{
                print("data error")
                return
            }
            //convert data to string
            var s : String = String(data:data, encoding: .ascii)!
            
            //make XML fonrm to standards
            s = s.replacingOccurrences(of: "\r", with: "\n")
            print(s)
            print("yhhh")
            //parse XML
        
            if let edit = s.range(of: "]") {
              s.removeSubrange(edit.lowerBound..<s.endIndex)
            }
            
            print("YUIEF")
            if let edit2 = s.range(of: "{") {
                s.removeSubrange(s.startIndex..<edit2.lowerBound)
            }
            print(s)
            self.value = s
            
            self.newCanteen = convertToDictionary(text: self.value)!
            
            let canteen = Canteen(Value: self.newCanteen["value"] as! Int, Color: self.newCanteen["color"] as! String, Label: self.newCanteen["label"] as! String)
            
            self.CanteenList.append(canteen)
            
            print(self.CanteenList.count)
            
            print(self.CanteenList[(self.CanteenList.count) - 1].color)
            
            self.makecircle(x: canteen)
            
//            print("circl")
//            var pos = CGPoint(x: 200, y: 200)
//
//            if self.CanteenList.count-1 == 0{
//                pos = CGPoint(x: 200, y: 200)
//                self.munchLabel = UILabel(frame: CGRect( x: 200, y: 200, width: 100, height: 50))
//                self.view.addSubview(self.munchLabel!)
//                let displayLink = CADisplayLink(target: self, selector: #selector(self.handleUpdate))
//                displayLink.add(to: .main, forMode: .default)
//
//
//
//                print("chosen point top")
//            }
//            else if self.CanteenList.count-1 == 1{
//                pos = CGPoint(x: 200, y: 415)
//                print("chosen point mid")
//            }
//            else if self.CanteenList.count-1 == 2{
//                pos = CGPoint(x: 200, y: 630)
//                print("chosen point btm")
//            }
//
//            let shapeLayer = CAShapeLayer()
//            let trackLayer = CAShapeLayer()
//
//            //track layer
//
//            let circularPath = UIBezierPath(arcCenter: pos, radius: 100, startAngle: -CGFloat.pi/2 , endAngle: 2 * CGFloat.pi, clockwise: true)
//            //let circularPath = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 100, height: 100))
//            trackLayer.path = circularPath.cgPath
//            trackLayer.strokeColor = UIColor.lightGray.cgColor
//            trackLayer.lineWidth = 10
//            trackLayer.fillColor = UIColor.clear.cgColor
//            trackLayer.lineCap = CAShapeLayerLineCap.round
//            print("Display track")
//            self.view.layer.addSublayer(trackLayer)
//            //load layer with the colour thing ynoe
//            shapeLayer.path = circularPath.cgPath
//            shapeLayer.strokeColor = UIColor.red.cgColor
//            shapeLayer.lineWidth = 10
//            shapeLayer.fillColor = UIColor.clear.cgColor
//            shapeLayer.lineCap = CAShapeLayerLineCap.round
//            //shapeLayer.strokeStart = 0.75
//            shapeLayer.strokeEnd = 0
//            self.view.layer.addSublayer(shapeLayer)
//            //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
//            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//            basicAnimation.toValue = 0.7//change this to change how much it moves
//            basicAnimation.duration = 1
//            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
//            basicAnimation.isRemovedOnCompletion = false
//            shapeLayer.add(basicAnimation, forKey: "basic animation")
            
            
            
            
            
        }
        
        session.resume()
        print("no more api")
    }
    
}


    




//food club amounts
struct fcA{
    public var value: String
    public var color: String
    public var label: String
}




func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

struct Response: Codable{
    public var value: Int
    public var color: String
    public var label: String
}


    

