//
//  FacebookAuthentication.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 22/02/23.
//

import Foundation
import FacebookLogin

final class FacebookAuthentication {
    let loginManager = LoginManager()
    
    func loginFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        loginManager.logIn(permissions: ["email"], from: nil) { loginManagerLoginResult, error in
            if let error = error {
                print("Error al iniciar sesion con Facebook: \(error)")
                completionBlock(.failure(error))
            }
            
            let token = loginManagerLoginResult?.token?.tokenString
            completionBlock(.success(token ?? "Token Vacio"))
            
        }
    }
    
}
