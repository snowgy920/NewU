//
//  ProgressWView.swift
//
//  Copyright © 2019 Alex. All rights reserved.
//

import os.log
import UIKit

class ProgressWView: UIView {
    
    @IBOutlet var canvasView: UIView!
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!

    var lTimer: Timer?
    var lTimerStep: CGFloat = 0

    
    var aniDur: CGFloat = 0
    var currentPercent: CGFloat = 0
    var percent: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view: UIView = Bundle.main.loadNibNamed("ProgressWView", owner: self, options: nil)!.first as! UIView
        addSubview(view)
    }

    override func draw(_ rect: CGRect) {
        subviews[0].frame = bounds

        let canvasWidth = rect.width
        let canvasHeight = rect.height
        
        let plHeight = canvasHeight * 0.1468
        
        // draw meter bar
        let barWidth = canvasWidth * 0.3127

        let barRect = CGRect(x: (canvasWidth-barWidth)/2, y: plHeight, width: barWidth, height: canvasHeight-3)
        let barPath = UIBezierPath(rect: barRect)
        UIColor(rgb: 0xe6e6e6).setFill()
        barPath.fill()
        
        // draw meter base line
        let blRect = CGRect(x: 0, y: canvasHeight-3, width: canvasWidth, height: 3)
        let blPath = UIBezierPath(rect: blRect)
        UIColor(rgb: 0x484747).setFill()
        blPath.fill()

//        let meterWidth1 = canvasWidth * 0.5289
//        let meterWidth2 = canvasWidth * 0.6198
//        let clHeight = (canvasHeight - 3 - plHeight) / 9
        // draw meter lines
//        let linesPath = UIBezierPath()
//        for i in 1...8 {
//            var l_left = (canvasWidth - meterWidth1) / 2
//            var l_width = meterWidth1
//            if i % 2 == 1 {
//                l_left = (canvasWidth - meterWidth2) / 2
//                l_width = meterWidth2
//            }
//            linesPath.move(to: CGPoint(x: l_left, y: plHeight + clHeight*CGFloat(i) ))
//            linesPath.addLine(to: CGPoint(x: l_left+l_width, y: plHeight + clHeight*CGFloat(i) ))
//        }
//        UIColor(rgb: 0x707070).setStroke()
//        linesPath.lineWidth = CGFloat(0.5)
//        linesPath.stroke()
        
        // draw 350cl line
//        let topLinePath = UIBezierPath()
//        topLinePath.move(to: CGPoint(x: 0, y: plHeight + clHeight*2.5))
//        topLinePath.addLine(to: CGPoint(x: canvasWidth, y: plHeight + clHeight*2.5 ))
//        UIColor(rgb: 0xE9707D).setStroke()
//        topLinePath.stroke()
    }

    /// Get an animation duration for the passed slice.
    /// If slice share is 40%, for example, it returns 40% of total animation duration.
    ///
    /// - Parameter slice: Slice struct
    /// - Returns: Animation duration
    func getDuration(_ percent: CGFloat) -> CFTimeInterval {
        if (aniDur == 0) {
            return CFTimeInterval(0)
        }
        if (aniDur > 0 && aniDur <= 0.5) {
            return CFTimeInterval(0.5)
        } else {
            return CFTimeInterval(percent * (aniDur-0.5) + 0.5)
        }
    }
    
    func doStart() {
        let canvasWidth = canvasView.frame.width
        let canvasHeight = canvasView.frame.height
        let barWidth = canvasWidth * 0.3127

        let plHeight = canvasHeight * 0.1468
        let plWidth = plHeight*2
        
        // add value layer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = getDuration(percent)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self

        lTimerStep = percent / CGFloat(animation.duration) / 10
        lTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(onLabelTimerFires), userInfo: nil, repeats: true)

        let linePath = UIBezierPath()
        let value = (canvasHeight-3-plHeight) * 13/18 * percent
        linePath.move(to: CGPoint(x: canvasWidth/2, y: canvasHeight-3))
        linePath.addLine(to: CGPoint(x: canvasWidth/2, y: canvasHeight-3-value))

        let sliceLayer = CAShapeLayer()
        sliceLayer.path = linePath.cgPath
        sliceLayer.strokeColor = UIColor(rgb: 0x32D3F5).cgColor
        sliceLayer.lineWidth = CGFloat(barWidth)
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
        canvasView.layer.addSublayer(sliceLayer)

        // draw meter lines
        let clHeight = (canvasHeight - 3 - plHeight) / 9
        let meterWidth1 = canvasWidth * 0.5289
        let meterWidth2 = canvasWidth * 0.6198

        let linesLayer = CAShapeLayer()
        let linesPath = UIBezierPath()
        for i in 1...8 {
            var l_left = (canvasWidth - meterWidth1) / 2
            var l_width = meterWidth1
            if i % 2 == 1 {
                l_left = (canvasWidth - meterWidth2) / 2
                l_width = meterWidth2
            }
            linesPath.move(to: CGPoint(x: l_left, y: plHeight + clHeight*CGFloat(i) ))
            linesPath.addLine(to: CGPoint(x: l_left+l_width, y: plHeight + clHeight*CGFloat(i) ))
        }
        linesLayer.path = linesPath.cgPath
        linesLayer.strokeColor = UIColor(rgb: 0x707070).cgColor
        linesLayer.lineWidth = CGFloat(0.5)
        canvasView.layer.addSublayer(linesLayer)

        // draw 350cl line
        let topLineLayer = CAShapeLayer()
        let topLinePath = UIBezierPath()
        topLinePath.move(to: CGPoint(x: 0, y: plHeight + clHeight*2.5))
        topLinePath.addLine(to: CGPoint(x: canvasWidth, y: plHeight + clHeight*2.5 ))
        topLineLayer.path = topLinePath.cgPath
        topLineLayer.strokeColor = UIColor(rgb: 0xE9707D).cgColor
        topLineLayer.lineWidth = CGFloat(1)
        canvasView.layer.addSublayer(topLineLayer)

        
        // draw percent label
        label5.text = String(format: "%d%%", Int(percent * 100))
        label5.layer.backgroundColor = UIColor(rgb: 0x484747).cgColor
        label5.layer.cornerRadius = plHeight*0.375
        label5.frame = CGRect(x: (canvasWidth-plWidth)/2, y: 0, width: plWidth, height: plHeight)
        label5.font = label5.font.withSize(plHeight*0.67)
        
        let clLWidth = canvasWidth * 0.4181
        let clLHeight = clLWidth * 0.6087
        let clLFont = clLHeight*0.67
        let clLeft1 = -clLWidth * 0.7826
        let clLeft2 = canvasWidth - clLWidth * 0.3478
        
        // draw cl meters
        label1.text = "100cl"
        label1.frame = CGRect(x: clLeft2, y: canvasHeight-3 - clHeight*2 - clLHeight/2, width: clLWidth, height: clLHeight)
        label1.font = label1.font.withSize(clLFont)

        label2.text = "200cl"
        label2.frame = CGRect(x: clLeft1, y: canvasHeight-3 - clHeight*4 - clLHeight/2, width: clLWidth, height: clLHeight)
        label2.font = label2.font.withSize(clLFont)

        label3.text = "300cl"
        label3.frame = CGRect(x: clLeft2, y: canvasHeight-3 - clHeight*6 - clLHeight/2, width: clLWidth, height: clLHeight)
        label3.font = label1.font.withSize(clLFont)
        
        label4.text = "400cl"
        label4.frame = CGRect(x: clLeft1, y: canvasHeight-3 - clHeight*8 - clLHeight/2, width: clLWidth, height: clLHeight)
        label4.font = label2.font.withSize(clLFont)
    }
    
    @objc func onLabelTimerFires() {
        currentPercent += lTimerStep
        label5.text = String(format: "%d%%", Int(currentPercent * 100))
    }

    /// Call this to start pie chart animation.
    func animateProgress(_ duration: CGFloat = 1.4) {
        aniDur = duration
        currentPercent = 0.0
        canvasView.layer.sublayers = nil
        doStart()
    }
}

extension ProgressWView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            currentPercent = percent

            lTimer?.invalidate()
            lTimer = nil
            label5.text = String(format: "%d%%", Int(currentPercent * 100))
        }
    }
}
