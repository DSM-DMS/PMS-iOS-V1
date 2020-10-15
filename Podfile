# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def pods
	pod 'SwiftLint'
	pod 'FSCalendar'
	pod 'CryptoSwift'
	pod 'Moya'
end

target 'PMS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PMS
	pods

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
