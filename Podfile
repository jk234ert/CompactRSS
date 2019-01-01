source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
inhibit_all_warnings!

def session_pods

  #Feeds Parser
  pod 'FeedKit', '~> 8.0.0'

  #Core pods
  pod 'PromiseKit', '~> 6.7.0'
  pod 'SwifterSwift', '~> 4.6.0'
  pod 'SwiftGen', '~> 6.0.2'
  pod 'DateToolsSwift', '~> 4.0.0'
  
  #UI
  pod 'Kingfisher', '~> 5.0.0'
  pod 'TinyConstraints', '~> 3.3.1'

  #DEBUG
  pod 'XCGLogger', '~> 6.1.0'
  pod 'GDPerformanceView', '~> 1.3.1'
  pod 'FLEX', '~> 2.0'
end

target 'CompactRss' do

  platform :ios, '10.0'

  session_pods

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end
