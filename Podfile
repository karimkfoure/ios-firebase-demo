# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'FirebaseDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FirebaseDemo
  pod 'PromiseKit'
  pod 'Resolver'
  pod 'Firebase/Auth'
  pod 'FirebaseFirestoreSwift'
  pod 'R.swift'
  pod 'IQKeyboardManagerSwift'
  pod 'ActionSheetPicker-3.0'
  
  target 'FirebaseDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
        end
      end
    end
end
