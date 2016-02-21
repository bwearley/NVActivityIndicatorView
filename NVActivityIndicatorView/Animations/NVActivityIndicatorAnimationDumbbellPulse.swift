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
        let y2 = layer.bounds.size.height - 4*y
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.4, 0.2, 0, 0.2, 0.4]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.85, 0.25, 0.37, 0.85)
        
        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.4, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false

        let animation2 = CAKeyframeAnimation(keyPath: "transform.scale.x")
        animation2.keyTimes = [0, 0.5, 1]
        animation2.timingFunctions = [timingFunction, timingFunction]
        animation2.values = [1, 0.4, 1]
        animation2.duration = duration
        animation2.repeatCount = HUGE
        animation2.removedOnCompletion = false
        
        // Draw plates
        let smPlateHeight = 0.5*size.height
        let lgPlateHeight = size.height


        let leftSmPlate = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: lineSize, height: smPlateHeight), color: color)
        animation.beginTime = beginTime + beginTimes[0]
        leftSmPlate.frame = CGRect(
            x: x + lineSize * CGFloat(0),
            y: y2,
            width: lineSize,
            height: smPlateHeight)
        leftSmPlate.addAnimation(animation, forKey: "animation")
        layer.addSublayer(leftSmPlate)

        let leftLgPlate = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: lineSize, height: lgPlateHeight), color: color)
        animation.beginTime = beginTime + beginTimes[1]
        leftLgPlate.frame = CGRect(
            x: x + lineSize * CGFloat(1),
            y: y,
            width: lineSize,
            height: lgPlateHeight)
        leftLgPlate.addAnimation(animation, forKey: "animation")
        layer.addSublayer(leftLgPlate)

        let rightSmPlate = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: lineSize, height: smPlateHeight), color: color)
        animation.beginTime = beginTime + beginTimes[0]
        rightSmPlate.frame = CGRect(
            x: x2 - lineSize - lineSize * CGFloat(0),
            y: y2,
            width: lineSize,
            height: smPlateHeight)

        rightSmPlate.addAnimation(animation, forKey: "animation")
        layer.addSublayer(rightSmPlate)

        let rightLgPlate = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: lineSize, height: lgPlateHeight), color: color)
        animation.beginTime = beginTime + beginTimes[1]
        rightLgPlate.frame = CGRect(
            x: x2 - lineSize - lineSize * CGFloat(1),
            y: y,
            width: lineSize,
            height: lgPlateHeight)
        rightLgPlate.addAnimation(animation, forKey: "animation")
        layer.addSublayer(rightLgPlate)

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
    }
}
