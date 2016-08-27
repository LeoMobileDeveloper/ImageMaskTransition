//
//  ImageMaskTransition.swift
//  ImageMaskTransition
//
//  Created by huangwenchen on 16/8/17.
//  Copyright © 2016年 Leo. All rights reserved.
//

import UIKit

public struct TransitionConfig{
   public  var fromImageView:UIImageView
   public  var toImageView:UIImageView?
   public  var blurRadius:CGFloat = 3.0
   public  var presentDuration = 1.6
   public var dismissDuration = 1.3
   public static func defaultConfig(fromImageView fromImageView:UIImageView,toImageView:UIImageView)->TransitionConfig{
        return TransitionConfig(fromImageView: fromImageView, toImageView: toImageView, blurRadius: 3.0, presentDuration: 1.6, dismissDuration: 1.3)
    }
}
public class ImageMaskTransition: NSObject,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate{
    public let config:TransitionConfig
    let animator:ImageMaskAnimator
    public init(config:TransitionConfig){
        self.config = config
        self.animator = ImageMaskAnimator(config: config)
        super.init()
    }
    // MARK: - UINavigationControllerDelegate -
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .Pop:
            self.animator.transitionType = ImageMaskTransitionType.Dismisss
            return self.animator
        case .Push:
            self.animator.transitionType = ImageMaskTransitionType.Present
            return self.animator
        default:
            return nil
        }
    }
    // MARK: - UIViewControllerTransitioningDelegate -
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.transitionType = ImageMaskTransitionType.Present
        return self.animator
    }
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.transitionType = ImageMaskTransitionType.Dismisss
        return self.animator
    }
}
