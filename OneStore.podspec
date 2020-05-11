Pod::Spec.new do |s|
  s.name             = 'OneStore'
  s.version          = '1.1.1'
  s.summary          = 'One value store proxy for NSUserDefaults'
  s.homepage         = 'https://github.com/muukii/OneStore'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'muukii' => 'muukii.app@gmail.com' }
  s.source           = { :git => 'https://github.com/muukii/OneStore.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii_app'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.13'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'OneStore/**/*.swift'
end
