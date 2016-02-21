//
//  NVActivityIndicatorAnimationDumbbellPulse.swift
//  NVActivityIndicatorViewDemo
//
//  Created by Brian Earley on 2/20/16.
//  Copyright © 2016 Nguyen Vinh. All rights reserved.
//
//  Created by Nguyen Vinh on 7/24/15.
//  Copyright © 2015 Nguyen Vinh. All rights reserved.
//

import UIKit

class NVActivityIndicatorAnimationDumbbellPulse: NVActivityIndicatorAnimationDelegate {
    
    func setUpAnimationInLayer(layer: CALayer, size: CGSize, color: UIColor) {
        let lineSize = size.width / 9
        let x = (layer.bounds.size.width - size.width) / 2
        let x2 = layer.bounds.size.width - x
        let y = (layer.bounds.size.height - size.height) / 2
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.4, 0.2, 0, 0.2, 0.4]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.85, 0.25, 0.37, 0.85)
        
        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        let animation2 = CAKeyframeAnimation(keyPath: "transform.scale.x")

        // Dumbbell Configuration
        let numPlates = 2
        
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.4, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false

        animation2.keyTimes = [0]
        animation2.timingFunctions = [timingFunction, timingFunction]
        animation2.values = [1, 0.4, 1]
        animation2.duration = duration
        animation2.repeatCount = HUGE
        animation2.removedOnCompletion = false
        
        // Draw lines
        for lineNum in 0...numPlates-1 {
            // Left side plates
            let line = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: lineSize, height: size.height), color: color)
            let frame = CGRect(
                x: x + lineSize * CGFloat(lineNum),
                y: y,
                width: lineSize,
                height: size.height)

            animation.beginTime = beginTime + beginTimes[lineNum]
            line.frame = frame
            line.addAnimation(animation, forKey: "animation")
            layer.addSublayer(line)
        }

        for lineNum in 0...numPlates-1 {
            // Right side plates
            let line = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: lineSize, height: size.height), color: color)
            let frame = CGRect(
                x: x2 - lineSize - lineSize * CGFloat(lineNum),
                y: y,
                width: lineSize,
                height: size.height)

            animation.beginTime = beginTime + beginTimes[lineNum]
            line.frame = frame
            line.addAnimation(animation, forKey: "animation")
            layer.addSublayer(line)
        }

        // Draw bar
        let bar = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: 0.5*size.width, height: lineSize), color: color)
        let barFrame = CGRect(
            x: 0.5*layer.bounds.size.width-0.5*0.5*size.width,
            y: 0.5*layer.bounds.size.height,
            width: 0.5*size.width,
            height: lineSize)

        animation2.beginTime = beginTime
        bar.frame = barFrame
        bar.addAnimation(animation2, forKey: "animation")
        layer.addSublayer(bar)

        layer.borderColor = UIColor.whiteColor().CGColor    // TODO: REMOVE THIS
        layer.borderWidth = 1                               // TODO: REMOVE THIS
    }
}
