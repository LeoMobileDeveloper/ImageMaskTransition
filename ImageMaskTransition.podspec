
Pod::Spec.new do |s|
  s.name             = 'ImageMaskTransition'
  s.version          = '0.1.1'
  s.summary          = 'Simple but powerful and beautiful ViewController transtion'
  s.description      = <<-DESC
This is a ViewController transition to create beautiful image transition between ViewControllers
                       DESC

  s.homepage         = 'https://github.com/LeoMobileDeveloper/ImageMaskTransition'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leo' => 'leomobiledeveloper@gmail.com' }
  s.source           = { :git => 'https://github.com/LeoMobileDeveloper/ImageMaskTransition.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Classes/**/*'
end