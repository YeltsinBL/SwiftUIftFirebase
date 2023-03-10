//
//  AuthenticationFirebaseDatasourece.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import Foundation
import FirebaseAuth

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
                completionBlock(.failure(error))
            }
        }
    }
    
    
//    para cerrar sesión o muestre un error si no se pudo realizar
    func logout() throws {
        try Auth.auth().signOut()
    }
    
//    obtener todos los proveedores con el mismo email
    func currentProvider () -> [LinkedAccounts] {
        guard let currentUser = Auth.auth().currentUser else {
            return []
        }
//        providerData: obtenemos un array con los IDs de los proveedores que tiene vinculado el currentUser
        let linkedAccounts = currentUser.providerData.map { userInfo in
//            recogemos los IDs de los proveedores y los transformamos a un modelo del dominio
            LinkedAccounts(rawValue: userInfo.providerID)
        }.compactMap{ $0 } // para eliminar todos los nil que haya en el array
        return linkedAccounts
    }
    
//    Vincular la cuenta de Facebook
    func linkFaceook(completionBlock: @escaping (Bool) -> Void) {
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().currentUser?.link(with: credential, completion: { authDataResult, error in
                    if let error =  error {
                        print("Error al vincular la credencial Facebook: \(error.localizedDescription)")
                        completionBlock(false)
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print("Nuevo user vinculado con el email: \(email)")
                    completionBlock(true)
                })
            case .failure(let error):
                print("Error al vincular una nueva cuenta de Facebook : \(error.localizedDescription)")
                completionBlock(false)
            }
        }
    }
    
//    Obtenemos la credencial de Facebook para vincular con otro proveedor
    func getCurrentCredential() -> AuthCredential? {
        guard let providerId = currentProvider().last else { return nil }
        switch providerId {
        case .emailAndPassword, .unknow:
            return nil
        case .facebook:
            guard let accessToken = facebookAuthentication.getAccessToken() else { return nil }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            return credential
        }
    }
//    vincular la cuenta con Email y password
    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping(Bool) -> Void) {
        guard let credential = getCurrentCredential() else {
            print("Error al obtener la credencial")
            completionBlock(false)
            return
        }
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { authDataResult, error in
            if let error =  error {
                print("Error al reautenticar al usuario: \(error.localizedDescription)")
                completionBlock(false)
                return
            }
//            creamos la credencial del email y password
            let emailAndPasswordCredential = EmailAuthProvider.credential(withEmail: email,
                                                                          password: password)
//            Vinculamos la cuenta con la nueva credencial del email y password
            Auth.auth().currentUser?.link(with: emailAndPasswordCredential,
                                          completion: { authDataResult, error in
                if let error =  error {
                    print("Error al vincular la credencial Email y password: \(error.localizedDescription)")
                    completionBlock(false)
                    return
                }
                let email = authDataResult?.user.email ?? "No email"
                print("Nuevo user vinculado con email: \(email)")
                completionBlock(true)
            })
            
        })
    }
}
