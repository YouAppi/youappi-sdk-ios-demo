workspace 'SimpleYouAppiApp.xcworkspace'
platform :ios, ‘9.0’

project 'AppDemoMoPub/AppDemoMoPub.xcodeproj'
project 'AppDemoAdMob/AppDemoAdMob.xcodeproj'

target 'AppDemo' do
    project 'AppDemo/AppDemo.xcodeproj'
    pod ‘YouAppiMoatSDK’, ‘4.4.0’
end

target 'AppDemoMoPub' do
    project 'AppDemoMoPub/AppDemoMoPub.xcodeproj'
    pod 'YouAppiMoPubAdapter'
    pod 'mopub-ios-sdk'
    pod ‘YouAppiMoatSDK’, ‘4.4.0’
end

target 'AppDemoAdMob' do
    project 'AppDemoAdMob/AppDemoAdMob.xcodeproj'
    pod 'Google-Mobile-Ads-SDK'
    pod 'YouAppiAdMobAdapter'
    pod ‘YouAppiMoatSDK’, ‘4.4.0’
    pod 'PersonalizedAdConsent'
end

