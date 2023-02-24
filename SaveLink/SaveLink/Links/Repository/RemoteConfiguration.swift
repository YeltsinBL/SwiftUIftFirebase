//
//  RemoteConfiguration.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 24/02/23.
//

import Foundation
import FirebaseRemoteConfig

final class RemoteConfiguration: ObservableObject {
    @Published var buttonTitle: String = ""
    var remoteConfig: RemoteConfig
    init() {
        remoteConfig = RemoteConfig.remoteConfig() //inicializamos
        let setting = RemoteConfigSettings()
//        tiempo mínimo a esperar para pedir otra información de los valores de las keys del remote config en segundos
        setting.minimumFetchInterval = 30
        remoteConfig.configSettings = setting
//        Valor por defecto mientras espera que llegue la información
        remoteConfig.setDefaults(["create_button_title": "Cargando..." as NSObject])
//        asignamos el valor al título del botón
        buttonTitle = remoteConfig.configValue(forKey: "create_button_title").stringValue ?? ""
    }
    
//    método pasa saber que título se le pone al botón de acuerdo a Firebase
    func fetch() {
        remoteConfig.fetchAndActivate { [weak self] succes, error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self?.buttonTitle = self?.remoteConfig.configValue(forKey: "create_button_title").stringValue ?? ""
            }
        }
    }
    
}
