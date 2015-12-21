Pod::Spec.new do |s|
  s.name         = "CHAction"
  s.version      = "0.0.1"
  s.summary      = "A Chain Action Framework. It includes both a synchronous and asynchronous API."
  s.description  = <<-DESC
                   DESC
  s.homepage     = "https://github.com/croef/CHAction"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "croef" => "changrong185@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/croef/CHAction.git", :branch => "master" }
  s.source_files  = "CHAction", "CHAction/**/*.{h,m}"
  s.public_header_files = "CHAction/**/*.h"
end
