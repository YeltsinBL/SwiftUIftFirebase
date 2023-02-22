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
    
//   Creamos la propiedad con su instancia a la clase de Facebook
    private let facebookAuthentication = FacebookAuthentication()
    
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
    
//    Iniciar sesión
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error al iniciar sesión: \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No Email"
            print("Sesión iniciada: \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
//    Iniciar sesión con Facebook registrando el token
    func loginWithFacebook(completionBlock: @escaping (Result<User, Error>) -> Void ){
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
//                Obtenemos las credenciales de Facebook con el token y
//                lo pasamos a Firebase para que inicie sesión
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        print("Error creando el  nuevo usuario \(error.localizedDescription)")
                        completionBlock(.failure(error))
                        return
                    }
                    
                    let email = authDataResult?.user.email ?? "Sin email"
                    print("Nuevo usuario creado con \(email)")
                    completionBlock(.success(.init(email: email)))
                }
            case .failure(let error):
                print("Error iniciando sesión con Facebook: \(error.localizedDescription)")
            }
        }
    }
    
    
//    para cerrar sesión o muestre un error si no se pudo realizar
    func logout() throws {
        try Auth.auth().signOut()
    }
    
}
