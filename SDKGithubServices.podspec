Pod::Spec.new do |spec|
  spec.name             = 'SDKGithubServices'
  spec.version          = '0.1.0'
  spec.summary          = 'Pod for services for request GitHub api'
 
  spec.description      = 'Pod for services for request GitHub api, lists of repositories'

  spec.homepage         = 'https://github.com/gabrielsousaleal/SDKGithubServices'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'Gabriel Sousa Leal' => 'gabrielsousaleal@hotmail.com' }
  spec.source           = { :git => 'https://github.com/gabrielsousaleal/SDKGithubServices.git', :tag => spec.version.to_s }
  spec.platform = :ios, '10.0'
 
  spec.vendored_frameworks = 'SDKGithubServices.xcframework'

  spec.ios.deployment_target = '10.0'
  
  spec.frameworks = 'UIKit'
  
end