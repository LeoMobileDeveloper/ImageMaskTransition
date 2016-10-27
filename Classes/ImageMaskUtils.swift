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
    func maskFrom(_ fromRect:CGRect,duration:TimeInterval ,complete:@escaping ()->() = {}){
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            complete()
        }
        let maskLayer = CAShapeLayer()
        let fromCenter = CGPoint(x: fromRect.origin.x + fromRect.size.width / 2.0, y: fromRect.origin.y + fromRect.size.height / 2)
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
        
        maskLayer.path = toPath.cgPath
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = duration
        basicAnimation.fromValue = fromPath.cgPath
        basicAnimation.toValue = toPath.cgPath
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        maskLayer.add(basicAnimation, forKey: "pathMask")
        self.layer.mask = maskLayer
        CATransaction.commit()
    }
    func maskTo(_ toRect:CGRect,duration:TimeInterval ,complete:@escaping ()->() = {}){
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            complete()
        }
        let maskLayer = CAShapeLayer()
        let toCenter = CGPoint(x: toRect.origin.x + toRect.size.width / 2.0, y: toRect.origin.y + toRect.size.height / 2)
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
        
        maskLayer.path = toPath.cgPath
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.duration = duration
        basicAnimation.fromValue = fromPath.cgPath
        basicAnimation.toValue = toPath.cgPath
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        maskLayer.add(basicAnimation, forKey: "pathMask")
        self.layer.mask = maskLayer
        CATransaction.commit()
    }
    func blurScreenShot(_ blurRadius:CGFloat)->UIImage?{
        guard self.superview != nil else{
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: frame.width, height: frame.height), false, 1)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        guard let blur = CIFilter(name: "CIGaussianBlur") else{
            return nil
        }
        blur.setValue(CIImage(image: image!), forKey: kCIInputImageKey)
        blur.setValue(blurRadius, forKey: kCIInputRadiusKey)
        let ciContext  = CIContext(options: nil)
        let result = blur.value(forKey: kCIOutputImageKey) as! CIImage!
        let boundingRect = CGRect(x:0,
                                  y: 0,
                                  width: frame.width,
                                  height: frame.height)
        
        let cgImage = ciContext.createCGImage(result!, from: boundingRect)
        let filteredImage = UIImage(cgImage: cgImage!)
        return filteredImage
    }
}

