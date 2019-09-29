//
//  ProgressHView.swift
//
//  Copyright © 2019 Alex. All rights reserved.
//

import os.log
import UIKit

class ProgressHView: UIView {
    
    @IBOutlet var canvasView: UIView!
    
    var aniDur: CGFloat = 0
    var currentPercent: CGFloat = 0
    var percent: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view: UIView = Bundle.main.loadNibNamed("ProgressHView", owner: self, options: nil)!.first as! UIView
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
    
    func doStart() {
        let canvasWidth = canvasView.frame.width
        let canvasHeight = canvasView.frame.height
        
        let lineWidth = canvasWidth * percent
        let lineHeight = canvasHeight * 8 / 12
        
        // add background layer
        let bgLayer = CAShapeLayer()
        let bgPath = UIBezierPath()
        bgPath.move(to: CGPoint(x: 0, y: canvasHeight/2))
        bgPath.addLine(to: CGPoint(x: canvasWidth, y: canvasHeight/2))

        bgLayer.path = bgPath.cgPath
        bgLayer.strokeColor = UIColor(rgb: 0xE6E6E6).cgColor
        bgLayer.lineWidth = canvasHeight
        bgLayer.strokeEnd = 1
        
        canvasView.layer.addSublayer(bgLayer)
        

        // add value layer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = getDuration(percent)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self

        let linePath = UIBezierPath()
        let lineY = lineHeight * 0.75 - lineHeight / 2
        linePath.move(to: CGPoint(x: 0, y: lineY))
        linePath.addLine(to: CGPoint(x: lineWidth, y: lineY))

        let sliceLayer = CAShapeLayer()
        sliceLayer.path = linePath.cgPath
        sliceLayer.strokeColor = UIColor(rgb: 0x32D3F5).cgColor
        sliceLayer.lineWidth = CGFloat(lineHeight)
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
        
        canvasView.layer.addSublayer(sliceLayer)
    }
    
    /// Call this to start pie chart animation.
    func animateProgress(_ duration: CGFloat = 1.4) {
        aniDur = duration
        currentPercent = 0.0
        canvasView.layer.sublayers = nil
        doStart()
    }
}

extension ProgressHView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            currentPercent = percent
        }
    }
}
