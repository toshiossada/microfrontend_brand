import Flutter
import UIKit
import PushIOManager
import UserNotifications

@available(iOS 10.0, *)
public var _notification: UNNotificationResponse? = nil

@available(iOS 10.0, *)
public class SwiftResponsysPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    static let PUSHIO_CONFIG = "pushio_config.json"
    private static var _instance: SwiftResponsysPlugin? = nil
    private var eventSink: FlutterEventSink?

    weak var currentNotificationHandler: AnyObject? = nil
    private var _channel: FlutterMethodChannel? = nil

    public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftResponsysPlugin()
    let eventChannel = FlutterEventChannel(name: "responsys/events", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)
    let channel = FlutterMethodChannel(name: "responsys/messages", binaryMessenger: registrar.messenger())

    registrar.addApplicationDelegate(instance);
    NotificationCenter.default.addObserver(instance,
                                           selector:#selector(onDidFinishLaunchWithOptions(_:)),
                                           name: UIApplication.didFinishLaunchingNotification,
                                           object: nil)
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance._channel = channel
    Self._instance = instance
  }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method) {
      case "init":
        initResponsys(result)
      case "registerUserId":
        registerUserId(call: call, result: result)
      case "unregisterUserId":
        unregisterUserId(result: result)
      case "getNotificationData":
        getNotificationData(result: result)
      case "loadCache":
        loadCache(result: result)
      default:
        result(FlutterMethodNotImplemented)
    }
  }

  public func loadCache(result: @escaping FlutterResult) {
    result(nil)
  }

  public func clearCache(result: @escaping FlutterResult) {
    result("clearCache")
  }

  public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
    /* Restore the original notification handler, if any. */
    if let defaultHandler = self.currentNotificationHandler as? UNUserNotificationCenterDelegate {
        UNUserNotificationCenter.current().delegate = defaultHandler
    }
    self.currentNotificationHandler = nil
  }

  public func initResponsys(_ result: @escaping FlutterResult) {
    PushIOManager.sharedInstance().configure(withFileName: Self.PUSHIO_CONFIG, completionHandler: { (configError, response) in
      if let error = configError {
        result(FlutterError(code: "-1", message: "Not able to configure the sdk \(error.localizedDescription)", details: nil))
      }
      
      PushIOManager.sharedInstance().register(forAllRemoteNotificationTypes: { (regTrackError, deviceToken) in
        if (regTrackError == nil) {
          do {
            try PushIOManager.sharedInstance().registerApp(completionHandler: { (regError, response) in
              if let error = regError {
                result(FlutterError(code: "-1", message: "Unable to register, reason: \(error)", details: nil))
              } else{
                result("Registration successful")
              }
            })
          } catch {
            result(FlutterError(code: "-1", message: "Unable to track registration locally, reason: \(error)", details: nil))
          }
        } else {
          result(FlutterError(code: "-1", message: "Unable to register, reason: regTrackError", details: nil))
        }
      })
    })
  }

  public func registerUserId(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments else {
        return
    }
    if let myArgs = args as? [String: Any],
       let userId = myArgs["userId"] as? String {
        PushIOManager.sharedInstance().registerUserID(userId)
        result(userId)
    } else {
        result(FlutterError(code: "-1", message: "iOS could not extract " +
        "flutter arguments in method: (registerUserId)", details: nil))
    }
  }

  public func unregisterUserId(result: @escaping FlutterResult) {
    PushIOManager.sharedInstance().unregisterUserID()
    result("User sucesfull unregistered")
  }
  
  public func getNotificationData(result: @escaping FlutterResult) {
    if let myDict:[String:AnyObject] = _notification?.notification.request.content.userInfo as? [String : AnyObject] {
      result(extractNotificationData(notification: myDict))
      _notification = nil
    } else {
      result(nil)
    }
  }
    
  public func extractNotificationData(notification: [String : AnyObject]) -> [String:AnyObject] {
    var _notification = notification
    let aps:[String:AnyObject] = _notification["aps"] as? [String : AnyObject] ?? [:]
    let alert:[String:AnyObject] = aps["alert"] as? [String : AnyObject] ?? [:]
    
    _notification["title"] = alert["title"] as AnyObject
    _notification["alert"] = alert["body"] as AnyObject
    _notification["messageId"] = notification["ei"] as AnyObject
    _notification["receivedDate"] = getDateAsString() as AnyObject
      
    return(_notification)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    return nil
  }
  
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink!(FlutterEndOfEventStream)
    eventSink = nil
    return nil
  }

  private func getDateAsString() -> String {
    let now = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)

    return formatter.string(from: now)
  }
}

@available(iOS 10.0, *)
extension SwiftResponsysPlugin {
        @objc func onDidFinishLaunchWithOptions(_ notification: NSNotification) {
        let notificationCenter = UNUserNotificationCenter.current()
        /* Holds the original notification delegate. */
        self.currentNotificationHandler = notificationCenter.delegate

        /* and replace it with us. */
        notificationCenter.delegate = self

        /* Register for remote notifications right away. */
        UIApplication.shared.registerForRemoteNotifications()

        /* To avoi memory leaks, we can desengage from this notification. */
        NotificationCenter.default.removeObserver(self)
    }
}

@available(iOS 10.0, *)
extension SwiftResponsysPlugin : UIApplicationDelegate {
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushIOManager.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }

    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        PushIOManager.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
    }

    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        PushIOManager.sharedInstance().didReceiveRemoteNotification(userInfo)
    }
}

@available(iOS 10.0, *)
extension SwiftResponsysPlugin : UNUserNotificationCenterDelegate {
    /* Handle notifications while the App is in the backg round: */
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        /* Pass forward to the original handler, if any. */
        if let defaultHandler = self.currentNotificationHandler as? UNUserNotificationCenterDelegate {
            defaultHandler.userNotificationCenter?(center, willPresent: notification, withCompletionHandler: completionHandler)
        } else {
            if (eventSink != nil) {
                if let myDict:[String:AnyObject] = notification.request.content.userInfo as? [String : AnyObject] {
                    eventSink!(extractNotificationData(notification: myDict))
                } else {
                    eventSink!(nil)
                }
            } else {
                PushIOManager.sharedInstance().userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
            }
        }
    }

    /* Process in-app notification settings. */
    @available(iOS 12.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        /* Pass forward to the original handler, if any. */
        if let defaultHandler = self.currentNotificationHandler as? UNUserNotificationCenterDelegate {
            defaultHandler.userNotificationCenter?(center, openSettingsFor: notification)
        }
    }

    /* Process the user handling of a notification (e.g.: a button click). */
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        /* Pass forward to the original handler, if any. */
        
        if let defaultHandler = self.currentNotificationHandler as? UNUserNotificationCenterDelegate {
            defaultHandler.userNotificationCenter?(center, didReceive: response, withCompletionHandler: completionHandler)
        } else {
            PushIOManager.sharedInstance().userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
        }
        _notification = response
    }
}
