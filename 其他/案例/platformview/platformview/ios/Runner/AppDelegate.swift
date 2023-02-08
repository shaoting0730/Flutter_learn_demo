import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let factory = PlatformTextViewFactory()
        let registrar = self.registrar(forPlugin: "platform_text_view_plugin")
      registrar!.register(factory, withId: "platform_text_view")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
