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
    let button = UIButton(type: .custom)
    let scrollView = UIScrollView()
    var topView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.backgroundColor = UIColor.white
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSize(width: self.view.bounds.size.width , height: self.view.bounds.size.height * 2)
        
        topView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width,height: 200)
        topView.image = UIImage(named: "topImage.jpg")
        
        scrollView.addSubview(topView)
        
        imageView.image = UIImage(named: "movie.jpg")
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 124)
        imageView.center = CGPoint(x: 60, y: 200)
        scrollView.addSubview(imageView)

        button.setTitle("Back", for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.sizeToFit()
        button.center = CGPoint(x: self.view.frame.width - 30, y: 25)
        view.addSubview(button)
        button.addTarget(self, action: #selector(DetailViewController.dismissController), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
    }
    func dismissController(){
        if self.navigationController != nil {
           _ =  self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
