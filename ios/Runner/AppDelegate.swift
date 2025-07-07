import Flutter
import UIKit
import GoogleMobileAds
import google_mobile_ads

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      let fullFactory = FullScreenNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self,
          factoryId: "fullNative",
          nativeAdFactory: fullFactory
      )
        
      let inverseMediumFactory = InverseMediumNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
         self,
         factoryId: "inverseMediumNative",
         nativeAdFactory: inverseMediumFactory
      )
        
      let inverseSmallFactory = InverseSmallNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self,
          factoryId: "inverseSmallNative",
          nativeAdFactory: inverseSmallFactory
      )
        
      let mediumFactory = MediumNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self,
          factoryId: "mediumNative",
          nativeAdFactory: mediumFactory
      )
        
      let smallFactory = SmallNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self,
          factoryId: "smallNative",
          nativeAdFactory: smallFactory
      )
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
      
      override func applicationWillTerminate(_ application: UIApplication) {
             FLTGoogleMobileAdsPlugin.unregisterNativeAdFactory(self, factoryId: "fullNative")
             FLTGoogleMobileAdsPlugin.unregisterNativeAdFactory(self, factoryId: "inverseMediumNative")
             FLTGoogleMobileAdsPlugin.unregisterNativeAdFactory(self, factoryId: "inverseSmallNative")
             FLTGoogleMobileAdsPlugin.unregisterNativeAdFactory(self, factoryId: "mediumNative")
             FLTGoogleMobileAdsPlugin.unregisterNativeAdFactory(self, factoryId: "smallNative")
             super.applicationWillTerminate(application)
      }
  }
