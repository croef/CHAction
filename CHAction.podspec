#
#  Be sure to run `pod spec lint CHAction.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "CHAction"
  s.version      = "0.0.1"
  s.summary      = "A Chain Action Framework. It includes both a synchronous and asynchronous API."
  s.homepage     = "https://github.com/croef/CHAction"
  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "croef" => "changrong185@gmail.com" }
  s.social_media_url   = "http://blog.cr185.com"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios
  s.source       = { :git => "https://github.com/croef/CHAction.git", :tag => "0.0.1" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "CHAction", "CHAction/**/*.{h,m}"
end
