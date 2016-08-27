//
//  ViewController.swift
//  ImageMaskTransition
//
//  Created by huangwenchen on 16/8/17.
//  Copyright © 2016年 Leo. All rights reserved.
//

import UIKit

class CollectionCell:UICollectionViewCell{
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}

class ViewController: UICollectionViewController {
    //Hold a reference here
    var imageMaskTransiton:ImageMaskTransition?
    
    var useModalPresent = true 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.registerClass(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? CollectionCell
        cell?.imageView.image = UIImage(named: "movie.jpg")
        return cell!
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionCell
        
        //Create a detail controller,the frame of toImageView in viewDidLoad should be the same after layoutsubviews
        let dvc = DetailViewController()
        let config = TransitionConfig.defaultConfig(fromImageView: cell.imageView, toImageView:dvc.imageView)
        imageMaskTransiton =  ImageMaskTransition(config: config)
        if useModalPresent{
            dvc.transitioningDelegate = imageMaskTransiton
            presentViewController(dvc, animated: true, completion: nil)
        }else{
            self.navigationController?.delegate = imageMaskTransiton
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        
    }
}

