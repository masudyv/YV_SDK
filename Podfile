# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

source 'https://cdn.cocoapods.org/'
source 'https://github.com/idwise/ios-sdk'

target 'YV_SDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!

  # Pods for YV_SDK
  pod 'IDWise', '4.7.0'
  target 'YV_SDKTests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
end