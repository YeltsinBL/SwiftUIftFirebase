//
//  Tracker.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 24/02/23.
//

import Foundation
import FirebaseAnalytics

final class Tracker {
//    método al obtener información de la url
    static func trackCreateLinkEvent(url: String) {
        Analytics.logEvent("CreateLinkEvent", parameters: ["url": url])
        print("Paso el LogEvent CreateLinkEvent")
    }
//    método al guardar la información
    static func trackSaveLinkEvent(){
        Analytics.logEvent("SaveLinkEvent", parameters: nil)
        print("Paso el LogEvent SaveLinkEvent")
    }
//    método cuando hubo un error al guardar la información
    static func trackErrorLinkEvent(error: String) {
        Analytics.logEvent("ErrorLinkEvent", parameters: ["error": error])
        print("Paso el LogEvent ErrorLinkEvent")
    }
}
