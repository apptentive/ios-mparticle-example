platform :ios, '15.0'

target 'iOSExample' do
    use_frameworks!

    pod 'mParticle-Apple-SDK', '~> 9.0'
    pod 'mParticle-Apptentive-7', '~> 9.0'

    # To test an unreleased Apptentive SDK, point ApptentiveKit at a local checkout:
    # pod 'ApptentiveKit', :path => '../apptentive-kit-ios'
end

# RoktContracts (a dependency of mParticle 9) declares iOS 13, which Xcode 27 no longer supports.
post_install do |installer|
    installer.pods_project.targets.each do |target|
        next unless target.name == 'RoktContracts'
        target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 15.0
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
            end
        end
    end
end
