//
//  ImageMaskTransition.swift
//  ImageMaskTransition
//
//  Created by huangwenchen on 16/8/17.
//  Copyright © 2016年 Leo. All rights reserved.
//

import UIKit

struct TransitionConfig{
    var fromImageView:UIImageView
    var toImageView:UIImageView?
    var blurRadius:CGFloat = 3.0
    var presentDuration = 1.6
    var dismissDuration = 1.3
    static func defaultConfig(fromImageView fromImageView:UIImageView,toImageView:UIImageView)->TransitionConfig{
        return TransitionConfig(fromImageView: fromImageView, toImageView: toImageView, blurRadius: 3.0, presentDuration: 1.6, dismissDuration: 1.3)
    }
}
class ImageMaskTransition: NSObject,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate{
    var config:TransitionConfig
    let animator:ImageMaskAnimator
    init(config:TransitionConfig){
        self.config = config
        self.animator = ImageMaskAnimator(config: config)
        super.init()
    }
    // MARK: - UINavigationControllerDelegate -
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.transitionType = ImageMaskTransitionType.Present
        return self.animator
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animator.transitionType = ImageMaskTransitionType.Dismisss
        return self.animator
    }
}
