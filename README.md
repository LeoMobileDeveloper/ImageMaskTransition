
<p align="center">

<img src="https://raw.github.com/LeoMobileDeveloper/ImageMaskTransition/master/Screenshot/logo.png"/>

</p>


 [![Version](https://img.shields.io/cocoapods/v/ImageMaskTransition.svg?style=flat)](http://cocoapods.org/pods/ImageMaskTransition)  [![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
 [![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
 [![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

Present then Dismiss

<p align="center">

<img src="https://raw.github.com/LeoMobileDeveloper/ImageMaskTransition/master/Screenshot/demo.gif" width="200"/>

</p>
## Require

- iOS 8
- Swift 2

!!!!!You need to run the Demo Project on device to see blur effect


## Install

CocoaPod

```
pod 'ImageMaskTransition', '~> 0.1.1'
```


## Useage

Hold a property of `ImageMaskTransition` in firstViewController

```
var imageMaskTransiton:ImageMaskTransition?
```

Present a View Controller

The frame of `toImageView` must be the final frame after layout

```
let dvc = DetailViewController()
let config = TransitionConfig.defaultConfig(fromImageView: cell.imageView, toImageView:dvc.imageView)
imageMaskTransiton =  ImageMaskTransition(config: config)
dvc.transitioningDelegate = imageMaskTransiton
presentViewController(dvc, animated: true, completion: nil)
```

Push a ViewController

```
let dvc = DetailViewController()
let config = TransitionConfig.defaultConfig(fromImageView: cell.imageView, toImageView:dvc.imageView)
imageMaskTransiton =  ImageMaskTransition(config: config)
self.navigationController?.delegate = imageMaskTransiton
self.navigationController?.pushViewController(dvc, animated: true)
```


## Author

Leo, leomobiledeveloper@gmail.com

## License

ImageMaskTransition is available under the MIT license. See the LICENSE file for more info.

## 中文
关于实现原理，参见这片博客

[实现一个复杂动画的界面转场（Swift）](http://blog.csdn.net/hello_hwc/article/details/52265854)

