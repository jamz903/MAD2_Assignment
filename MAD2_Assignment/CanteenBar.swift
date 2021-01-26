//
//  CanteenBar.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 26/1/21.
//

import UIKit

class CanteenBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect){
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate var countLayer = UILabel()
    
    var progressColour = UIColor.white {
        didSet{
            progressLayer.strokeColor = progressColour.cgColor
        }
    }
    
    var trackColour = UIColor.white {
        didSet{
            trackLayer.strokeColor = trackColour.cgColor
        }
    }
    
    
    
    fileprivate func createCircularPath(){
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: 75, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColour.cgColor
        trackLayer.lineWidth = 10.0
        trackLayer.strokeEnd = 1.0
        trackLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColour.cgColor
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0.8
        progressLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(progressLayer)
        
        
    }
    
    func setAnimation(duration: TimeInterval, value:Float){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value //from 0 to like 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        
        
        
        //animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation,forKey: "animateAmount")
        
        
        
        
        
        
    }
    
    
    }

