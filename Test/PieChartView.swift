//
//  PieChartView.swift
//  PieChart
//
//  Copyright © 2019 TNODA.com. All rights reserved.
//

import os.log
import UIKit

class PieChartView: UIView {
    
    @IBOutlet var canvasView: UIView!
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    
    @IBOutlet var label1XConst: NSLayoutConstraint!
    @IBOutlet var label2XConst: NSLayoutConstraint!
    @IBOutlet var label3XConst: NSLayoutConstraint!
    @IBOutlet var label4XConst: NSLayoutConstraint!
    @IBOutlet var label5XConst: NSLayoutConstraint!

    @IBOutlet var label1YConst: NSLayoutConstraint!
    @IBOutlet var label2YConst: NSLayoutConstraint!
    @IBOutlet var label3YConst: NSLayoutConstraint!
    @IBOutlet var label4YConst: NSLayoutConstraint!
    @IBOutlet var label5YConst: NSLayoutConstraint!
    
    var aniDur: CGFloat = 0
    var percent: CGFloat = 0
    var degreePercent: CGFloat = 0
    var currentPercent: CGFloat = 0.0
    
    var lTimer:Timer?
    var lTimerStep: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view: UIView = Bundle.main.loadNibNamed("PieChartView", owner: self, options: nil)!.first as! UIView
        addSubview(view)
    }

    override func draw(_ rect: CGRect) {
        subviews[0].frame = bounds
    }

    /// Get an animation duration for the passed slice.
    /// If slice share is 40%, for example, it returns 40% of total animation duration.
    ///
    /// - Parameter slice: Slice struct
    /// - Returns: Animation duration
    func getDuration(_ perc: CGFloat) -> CFTimeInterval {
        if (aniDur == 0) {
            return CFTimeInterval(0)
        }
        if (aniDur > 0 && aniDur <= 0.5) {
            return CFTimeInterval(0.5)
        } else {
            return CFTimeInterval(perc * (aniDur-0.5) + 0.5)
        }
    }
    
    /// Convert slice percent to radian.
    ///
    /// - Parameter percent: Slice percent (0.0 - 1.0).
    /// - Returns: Radian
    func percentToRadian(_ percent: CGFloat) -> CGFloat {
        //Because angle starts wtih X positive axis, add 270 degrees to rotate it to Y positive axis.
        var angle = 150 + percent * 360
        if angle >= 360 {
            angle -= 360
        }
        return angle * CGFloat.pi / 180.0
    }

    /// Add a slice CAShapeLayer to the canvas.
    ///
    /// - Parameter slice: Slice to be drawn.
    func addSlice() {
        let canvasWidth = canvasView.frame.width
        
        let mboxWidth = canvasWidth * 0.95
        let mlineWidth = mboxWidth * 0.19
        let llineWidth = canvasWidth * 0.125
        
        let boxRadius = (mboxWidth - mlineWidth) / 2
        let lineRadius = (canvasWidth - llineWidth) / 2

        
        // add background layer
        let bgLayer = CAShapeLayer()
        let bgPath = UIBezierPath(arcCenter: canvasView.center,
                                radius: CGFloat(boxRadius),
                                startAngle: percentToRadian(0),
                                endAngle: percentToRadian(0.67),
                                clockwise: true)

        bgLayer.path = bgPath.cgPath
        bgLayer.fillColor = nil
        bgLayer.strokeColor = UIColor(rgb: 0xE6E6E6).cgColor
        bgLayer.lineWidth = CGFloat(mlineWidth)
        bgLayer.strokeEnd = 1
        
        canvasView.layer.addSublayer(bgLayer)
        

        // add value layer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = getDuration(percent)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self

        lTimerStep = percent / CGFloat(animation.duration) / 10
        lTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(onLabelTimerFires), userInfo: nil, repeats: true)

        let slicePath = UIBezierPath(arcCenter: canvasView.center,
                                radius: CGFloat(lineRadius),
                                startAngle: percentToRadian(0),
                                endAngle: percentToRadian(degreePercent),
                                clockwise: true)

        let sliceLayer = CAShapeLayer()
        sliceLayer.path = slicePath.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.strokeColor = UIColor(rgb: 0x32D3F5).cgColor
        sliceLayer.lineWidth = CGFloat(llineWidth)
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
        
        canvasView.layer.addSublayer(sliceLayer)
    }
    
    /// Re-position and draw label such as "43%".
    ///
    /// - Parameter slice: Slice whose label is drawn.
    func addPercentLabel() {
        let canvasWidth = canvasView.frame.width
        let lWidth = canvasWidth*0.257
        let lHeight = lWidth/34*15

        label1.text = String(format: "%d%%", Int(currentPercent * 100))
        label1.layer.backgroundColor = UIColor(rgb: 0x484747).cgColor
        label1.layer.cornerRadius = lHeight*6/15
        label1.frame = CGRect(x: (canvasWidth-lWidth)/2, y: canvasWidth*0.2768, width: lWidth, height: lHeight)
        label1.font = label1.font.withSize(lHeight*10/15)
    }
    
    @objc func onLabelTimerFires() {
        currentPercent += lTimerStep
        label1.text = String(format: "%d%%", Int(currentPercent * 100))
    }
    
    /// Call this to start pie chart animation.
    func animateChart(_ duration: CGFloat = 1.4) {
        aniDur = duration
        currentPercent = 0.0
        canvasView.layer.sublayers = nil
        
        degreePercent = percent * 0.67
        addPercentLabel()
        addSlice()
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension PieChartView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            //After animation is done, kill timer
            label1.text = String(format: "%d%%", Int(percent * 100))
            
            lTimer?.invalidate()
            lTimer = nil
        }
    }
}
