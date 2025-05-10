platform :ios, '15.0'

target 'MusicApp(final_project)' do
  use_frameworks!
	
  # Firebase SDKs
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseStorage'
  pod 'SDWebImageSwiftUI'
  # Firebase для Google входа
  pod 'GoogleSignIn'

  # Facebook SDK для входа
  pod 'FBSDKLoginKit'

  # Apple Sign In (он встроен в iOS, но Firebase его поддерживает)
  pod 'FirebaseAuth'

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'abseil'
      Pod::UI.puts "Workaround: Configuring abseil to use gnu++14 language standard for cocoapods 1.16+ compatibility".yellow
      Pod::UI.puts "            Remove workaround when upstream issue fixed https://github.com/firebase/firebase-ios-sdk/issues/13996".yellow
      target.build_configurations.each do |config|
        config.build_settings['CLANG_CXX_LANGUAGE_STANDARD'] = 'gnu++14'
      end
    end
  end
end