Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "YV_SDK"
s.summary = "YV_SDK lets users access all of YouVerify's services"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Mas'ud Onikeku" => "masud@youverify.co" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/masudyv/YV_SDK"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/masudyv/YV_SDK.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'IDWise', '4.7.0'
#s.dependency 'Alamofire', '~> 4.7'


# 8
s.source_files = "YV_SDK/**/*.{swift}"

# 9
#s.resources = "RWPickFlavor/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
#s.swift_version = "4.2"

end