
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

<img src="https://raw.github.com/LeoMobileDeveloper/ImageMaskTransition/master/Screenshot/demo.gif" width="300"/>

## Require

- iOS 8
- Swift 2

!!!!!You need to run the Demo Project on device to see blur effect


## Install

CocoaPod

```
pod "ImageMaskTransition"
```


## Useage

Hold a property of firstViewController

```
var imageMaskTransiton:ImageMaskTransition?
```

Present a View Controller

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

PullToRefreshKit is available under the MIT license. See the LICENSE file for more info.
