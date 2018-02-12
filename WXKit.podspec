#
# Be sure to run `pod lib lint WXKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WXKit'
  s.version          = '0.2.4'
  s.summary          = '自定义工具库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/icofans/WXKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'icofans' => '565057208@qq.com' }
  s.source           = { :git => 'https://github.com/icofans/WXKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.source_files = 'WXKit/**/*.{h,m}'

  s.source_files = 'WXKit/WXKit.h'
  s.public_header_files = 'WXKit/**/*.{h}'

  s.subspec 'Base' do |ss|
    ss.source_files = 'WXKit/Base/*.{h,m}'
  end

  s.subspec 'Categories' do |ss|
    ss.source_files = 'WXKit/Categories/*.{h,m}'
    ss.dependency 'WXKit/Base'
  end

  s.subspec 'Utils' do |ss|
    ss.source_files = 'WXKit/Utils/*.{h,m}'
    ss.frameworks = 'AVFoundation','AudioToolbox'
  end

  s.subspec 'Components' do |ss|
    ss.source_files = 'WXKit/Components/*.{h,m}'
  end

  # s.resource_bundles = {
  #   'WXKit' => ['WXKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

end
