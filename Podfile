# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def pods
	pod 'SwiftLint'
	pod 'FSCalendar'
	pod 'Moya', '~> 15.0.0-alpha.1'
end

target 'PMS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PMS
	pods
	pod 'lottie-ios'

  target 'PMSTests' do
    inherit! :search_paths
    # Pods for testing
	pods
  end

  target 'PMSUITests' do
    # Pods for testing
	pods
  end

end
