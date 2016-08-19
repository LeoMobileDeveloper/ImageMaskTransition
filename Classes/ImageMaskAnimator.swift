//
//  ImagePresentAnimator.swift
//  ImageMaskTransition
//
//  Created by huangwenchen on 16/8/17.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Foundation
import UIKit

enum ImageMaskTransitionType{
    case Present
    case Dismisss
}
class ImageMaskAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    var config:TransitionConfig
    var maskContentView:UIImageView!
    var imageView:UIImageView!
    var blurImage:UIImage?
    var transitionType:ImageMaskTransitionType = .Present
    init(config:TransitionConfig) {
        self.config = config
        super.init()
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containView = transitionContext.containerView()!
        let frame = UIScreen.mainScreen().bounds
        maskContentView = UIImageView(frame: frame)
        maskContentView.backgroundColor = UIColor.lightGrayColor()
        
        if self.transitionType == .Present {
            //Create Content Blur View
            #if (arch(i386) || arch(x86_64)) && os(iOS)
                print("Wow,CIFilter is too slow on simulator,So I disable blur on Simulator")
            #else
                self.blurImage = fromView.blurScreenShot(3.0)
                maskContentView.image = fromView.blurScreenShot(3.0)
            #endif
            maskContentView.frame = containView.bounds
            containView.addSubview(self.maskContentView)
            
            let fromImageView = self.config.fromImageView
            let adjustFromRect = fromImageView.convertRect(fromImageView.bounds, toView: containView)
            
            let toImageView = self.config.toImageView!
            let adjustToRect = toImageView.convertRect(toImageView.bounds, toView: containView)

            imageView = UIImageView(frame: adjustFromRect)
            imageView.image = fromImageView.image
            containView.addSubview(imageView)
            
            //Set up shadow
            imageView.layer.shadowColor = UIColor.blackColor().CGColor
            imageView.layer.shadowOffset = CGSizeMake(2.0, 2.0)
            imageView.layer.shadowRadius = 10.0
            imageView.layer.shadowOpacity = 0.8
            
            //Animation phase 1,change transform and frame
            UIView.animateWithDuration(0.5 / 1.6 * self.config.presentDuration, animations: {
                self.imageView.frame = adjustToRect
                self.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (finished) in
                //Animation phase 2,change transform to default,clear shadow
                UIView.animateWithDuration(0.3 / 1.6 * self.config.presentDuration, animations: {
                    self.imageView.transform = CGAffineTransformIdentity
                    self.imageView.layer.shadowOpacity = 0.0
                }) { (finished) in
                    //Animation phase 3,start mask animation
                    containView.addSubview(toView)
                    containView.bringSubviewToFront(self.imageView)
                    let adjustFrame = self.imageView.convertRect(self.imageView.bounds, toView: self.maskContentView)
                    toView.maskFrom(adjustFrame, duration: 0.8 / 1.6 * self.config.presentDuration,complete: {
                        self.maskContentView.removeFromSuperview()
                        self.imageView.removeFromSuperview()
                        self.maskContentView = nil
                        self.imageView = nil
                        transitionContext.completeTransition(true)
                    })
                }
            }
        }else{
            #if (arch(i386) || arch(x86_64)) && os(iOS)
                print("Wow,CIFilter is too slow on simulator,So I disable blur on Simulator")
            #else
                maskContentView.image = self.blurImage
            #endif
            maskContentView.frame = containView.bounds
            containView.addSubview(self.maskContentView)
            
            let fromImageView = self.config.fromImageView
            let toImageView = self.config.toImageView!
            let adjustFromRect = fromImageView.convertRect(fromImageView.bounds, toView: containView)
            let adjustToRect = toImageView.convertRect(toImageView.bounds, toView: containView)
            imageView = UIImageView(frame:adjustToRect)
            imageView.image = fromImageView.image
            containView.addSubview(imageView)
            
            //Animation phase 1,animate mask
            containView.bringSubviewToFront(self.imageView)
            containView.sendSubviewToBack(maskContentView)
            let adjustFrame = self.imageView.convertRect(self.imageView.bounds, toView: self.maskContentView)
            fromView.maskTo(adjustFrame, duration: 0.8 / 1.3 * self.config.dismissDuration,complete: {
                //Set up shadow
                self.imageView.layer.shadowColor = UIColor.blackColor().CGColor
                self.imageView.layer.shadowOffset = CGSizeMake(2.0, 2.0)
                self.imageView.layer.shadowRadius = 10.0
                self.imageView.layer.shadowOpacity = 0.8
                UIView.animateWithDuration(0.5 / 1.3 * self.config.dismissDuration, animations: {
                    self.imageView.frame = adjustFromRect
                }) { (finished) in
                    self.maskContentView.removeFromSuperview()
                    self.imageView.removeFromSuperview()
                    self.maskContentView = nil
                    self.imageView = nil
                    self.config.toImageView = nil
                    containView.addSubview(toView)
                    transitionContext.completeTransition(true)
                    //Animation phase 2,change transform to default,clear shadow
                }

            })
        }

    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.transitionType == .Present ? self.config.presentDuration:self.config.dismissDuration
    }
}
