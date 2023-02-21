//
//  SaveLinkApp.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import SwiftUI
import Firebase

//creamos la class 'AppDelegate' porque esta inicializando Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure() //inicializar Firebase

    return true
  }
}


@main
struct SaveLinkApp: App {
//    Registramos la clase 'AppDelegate para configurar Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
