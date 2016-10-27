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
        self.collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.backgroundColor = UIColor.white
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionCell
        cell?.imageView.image = UIImage(named: "movie.jpg")
        return cell!
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
        
        //Create a detail controller,the frame of toImageView in viewDidLoad should be the same after layoutsubviews
        let dvc = DetailViewController()
        let config = TransitionConfig.defaultConfig(fromImageView: cell.imageView, toImageView:dvc.imageView)
        imageMaskTransiton =  ImageMaskTransition(config: config)
        if useModalPresent{
            dvc.transitioningDelegate = imageMaskTransiton
            present(dvc, animated: true, completion: nil)
        }else{
            self.navigationController?.delegate = imageMaskTransiton
            self.navigationController?.pushViewController(dvc, animated: true)
        }
        
    }
}

