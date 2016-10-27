//
//  ImageMaskTransition.swift
//  ImageMaskTransition
//
//  Created by huangwenchen on 16/8/17.
//  Copyright © 2016年 Leo. All rights reserved.
//

import UIKit

public struct TransitionConfig{
   public var fromImageView:UIImageView
   public var toImageView:UIImageView?
   public var blurRadius:CGFloat = 3.0
   public var presentDuration = 1.6
   public var dismissDuration = 1.3
   public static func defaultConfig(fromImageView:UIImageView,toImageView:UIImageView)->TransitionConfig{
        return TransitionConfig(fromImageView: fromImageView, toImageView: toImageView, blurRadius: 3.0, presentDuration: 1.6, dismissDuration: 1.3)
    }
}
open class ImageMaskTransition: NSObject,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate{
    open let config:TransitionConfig
    let animator:ImageMaskAnimator
    public init(config:TransitionConfig){
        self.config = config
        self.animator = ImageMaskAnimator(config: config)
        super.init()
    }
    // MARK: - UINavigationControllerDelegate -
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            self.animator.transitionType = ImageMaskTransitionType.Dismisss
            return self.animator
        case .push:
            self.animator.transitionType = ImageMaskTransitionType.Present
            return self.animator
        default:
            return nil
        }
    }
    // MARK: - UIViewControllerTransitioningDelegate -
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.transitionType = ImageMaskTransitionType.Present
        return self.animator
    }
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.transitionType = ImageMaskTransitionType.Dismisss
        return self.animator
    }
}
