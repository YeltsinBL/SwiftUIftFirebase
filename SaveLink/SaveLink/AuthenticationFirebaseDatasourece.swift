//
//  AuthenticationFirebaseDatasourece.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthenticationFireBaseDataSource {
    
//    obtener la sesión actual del usuario
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        print("sesionActiva: \(email)")
        return .init(email: email)
    }
    
//    Creación del nuevo usuario
//    completionBlock: notifica a las capas superiores(repositorio, viewmodel y vista) si ha habido un error o no al crear el nuevo usuario en Firebase
//    @escaping (Result<User, Error>): si todo a ido bien devuelve el usuario sino un error
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error al crear el nueo usuario \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No Email"
            print("Nuevo usuario creado: \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
}
