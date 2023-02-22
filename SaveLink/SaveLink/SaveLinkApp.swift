//
//  SaveLinkApp.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import SwiftUI
import Firebase
import FacebookLogin

//creamos la class 'AppDelegate' porque esta inicializando Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure() //inicializar Firebase
      ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

    return true
  }
}


@main
struct SaveLinkApp: App {
//    Registramos la clase 'AppDelegate para configurar Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//Pasa saber si el usuario esta logueado o no
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.user?.email != nil {
//                Text("Usuario Logueado! \(user.email)")
                HomeView(authenticationViewModel: authenticationViewModel)
            } else {
                AuthenticationView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
