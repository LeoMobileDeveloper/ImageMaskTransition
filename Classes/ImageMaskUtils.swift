//
//  Utils.swift
//  ImageMaskTransition
//
//  Created by huangwenchen on 16/8/17.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func maskFrom(fromRect:CGRect,duration:NSTimeInterval ,complete:()->() = {}){
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            complete()
        }
        let maskLayer = CAShapeLayer()
        let fromCenter = CGPointMake(fromRect.origin.x + fromRect.size.width / 2.0, fromRect.origin.y + fromRect.size.height / 2)
        let fromRadius = min(fromRect.width/2,fromRect.height/2)
        let fromPath = UIBezierPath(arcCenter: fromCenter, radius: fromRadius, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)

        let viewWidth = self.frame.size.width
        let viewHeight = self.frame.size.height
        
        let r1 = sqrt(fromCenter.x * fromCenter.x + fromCenter.y * fromCenter.y)
        let r2 = sqrt((fromCenter.x - viewWidth)  * (fromCenter.x - viewWidth) + fromCenter.y * fromCenter.y)
        let r32 = (fromCenter.x - viewWidth)  * (fromCenter.x - viewWidth) + (fromCenter.y - viewHeight) * (fromCenter.y - viewHeight)
        let r3 = sqrt(r32)
        let r4 = sqrt(fromCenter.x * fromCenter.x + (fromCenter.y - viewHeight) * (fromCenter.y - viewHeight))
        let toRadius = max(max(max(r1,r2),r3),r4)

        let toPath = UIBezierPath(arcCenter: fromCenter, radius: toRadius, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        
        maskLayer.path = toPath.CGPath
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = duration
        basicAnimation.fromValue = fromPath.CGPath
        basicAnimation.toValue = toPath.CGPath
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        maskLayer.addAnimation(basicAnimation, forKey: "pathMask")
        self.layer.mask = maskLayer
        CATransaction.commit()
    }
    func maskTo(toRect:CGRect,duration:NSTimeInterval ,complete:()->() = {}){
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            complete()
        }
        let maskLayer = CAShapeLayer()
        let toCenter = CGPointMake(toRect.origin.x + toRect.size.width / 2.0, toRect.origin.y + toRect.size.height / 2)
        let toRadius:CGFloat = 0.001
        let toPath = UIBezierPath(arcCenter: toCenter, radius: toRadius, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        
        let viewWidth = self.frame.size.width
        let viewHeight = self.frame.size.height
        
        let r1 = sqrt(toCenter.x * toCenter.x + toCenter.y * toCenter.y)
        let r2 = sqrt((toCenter.x - viewWidth)  * (toCenter.x - viewWidth) + toCenter.y * toCenter.y)
        let r32 = (toCenter.x - viewWidth)  * (toCenter.x - viewWidth) + (toCenter.y - viewHeight) * (toCenter.y - viewHeight)
        let r3 = sqrt(r32)
        let r4 = sqrt(toCenter.x * toCenter.x + (toCenter.y - viewHeight) * (toCenter.y - viewHeight))
        let fromRadius = max(max(max(r1,r2),r3),r4)
        
        let fromPath = UIBezierPath(arcCenter: toCenter, radius: fromRadius, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        
        maskLayer.path = toPath.CGPath
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = duration
        basicAnimation.fromValue = fromPath.CGPath
        basicAnimation.toValue = toPath.CGPath
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        maskLayer.addAnimation(basicAnimation, forKey: "pathMask")
        self.layer.mask = maskLayer
        CATransaction.commit()
    }
    func blurScreenShot(blurRadius:CGFloat)->UIImage?{
        guard self.superview != nil else{
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: frame.width, height: frame.height), false, 1)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        guard let blur = CIFilter(name: "CIGaussianBlur") else{
            return nil
        }
        blur.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        blur.setValue(blurRadius, forKey: kCIInputRadiusKey)
        let ciContext  = CIContext(options: nil)
        let result = blur.valueForKey(kCIOutputImageKey) as! CIImage!
        let boundingRect = CGRect(x:0,
                                  y: 0,
                                  width: frame.width,
                                  height: frame.height)
        
        let cgImage = ciContext.createCGImage(result, fromRect: boundingRect)
        let filteredImage = UIImage(CGImage: cgImage)
        return filteredImage
    }
}

