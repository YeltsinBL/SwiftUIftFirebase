//
//  SaveLinkApp.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import SwiftUI
import Firebase
import FacebookLogin
import FirebaseMessaging

//creamos la class 'AppDelegate' porque esta inicializando Firebase
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure() //inicializar Firebase
      ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
      requestAuthorizationForPushNotification(application: application)
      
    return true
  }
//    recibir notificacion cuando la aplicacion esta en primer plano
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
//    metodo para pedir permiso a recibir notificaciones
    private func requestAuthorizationForPushNotification(application: UIApplication) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
            application.registerForRemoteNotifications()
        }
//    metodo para pasar el token de nuestro dispositivo y lo envie a Firebase
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        recuperamos el token del APNs y lo asignamos al token de FCM
        Messaging.messaging().apnsToken = deviceToken
    }
    
}


@main
struct SaveLinkApp: App {
//    Registramos la clase 'AppDelegate para configurar Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//Pasa saber si el usuario esta logueado o no
    @StateObject var authenticationViewModel = AuthenticationViewModel()
//    instanciamos e inyectamos
    @StateObject var remoteConfiguration = RemoteConfiguration()
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.user?.email != nil {
//                Text("Usuario Logueado! \(user.email)")
                HomeView(authenticationViewModel: authenticationViewModel)
                    .environmentObject(remoteConfiguration)
            } else {
                AuthenticationView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
