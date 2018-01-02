# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

# # Developer Helpers
pod 'SwifterSwift'

# # Logic

pod 'GoogleMaps'

# # DB & Networking
pod 'Moya-ObjectMapper'
pod 'Moya', '~> 8.0'
pod 'ObjectMapper', '~> 2.2'
pod 'SwiftSpinner'

post_install do |installer|
	swift40Targets = ['SwifterSwift']
	
	installer.pods_project.targets.each do |target|
		if swift40Targets.include? target.name
			target.build_configurations.each do |config|
				config.build_settings['SWIFT_VERSION'] = '4.0'
			end
		end
	end
end

target 'Navi Bike' do

end

