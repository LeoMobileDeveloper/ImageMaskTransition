//
//  DetailViewController.swift
//  ImageMaskTransition
//
//  Created by huangwenchen on 16/8/18.
//  Copyright © 2016年 Leo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let imageView = UIImageView()
    let button = UIButton(type: .Custom)
    let scrollView = UIScrollView()
    var topView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.backgroundColor = UIColor.orangeColor()
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height * 2)
        
        topView.backgroundColor = UIColor.redColor()
        topView.frame = CGRectMake(0, 0, self.view.bounds.size.width,200)
        scrollView.addSubview(topView)
        
        imageView.image = UIImage(named: "movie.jpg")
        imageView.frame = CGRectMake(0, 0, 80, 124)
        imageView.center = CGPointMake(self.view.bounds.size.width/2.0, 200)
        scrollView.addSubview(imageView)

        button.setTitle("Back", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.sizeToFit()
        button.center = CGPointMake(self.view.bounds.size.width/2.0, 40)
        view.addSubview(button)
        button.addTarget(self, action:#selector(DetailViewController.dismiss), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    func dismiss(){
        if self.navigationController != nil {
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
