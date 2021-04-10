Pod::Spec.new do |s|
  spec.name             = 'SDKGithubServices'
  spec.version          = '0.1.0'
  spec.summary          = 'Pod for services for request GitHub api'
 
  spec.description      = 'Pod for services for request GitHub api'

  spec.homepage         = 'https://github.com/gabrielsousaleal/SDKGithubServices'
  spec.author           = { 'Gabriel Sousa Leal' => 'gabrielsousaleal@hotmail.com' }
  spec.source           = { :git => 'https://github.com/gabrielsousaleal/SDKGithubServices', :tag => spec.version.to_s }
  spec.platform = :iOS, '10.0'
 
  spec.default_subspecs = 'Core'

  spec.subspec "Debug" do |debug|
    debug.source_files = 'SDKGithubServices/SDKGithubServices/Sources/**/*'
    debug.resource_files = 'SDKGithubServices/SDKGithubServices/Resources/**/*'
  end

  spec.subspec "Core" do |release|
    Release.vendored_frameworks = 'SDKGithubServices.xcframework'
  end

  spec.ios.development_target = '10.0'
  spec.swift_version = 5.0
