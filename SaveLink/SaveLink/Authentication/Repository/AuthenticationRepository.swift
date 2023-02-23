//
//  AuthenticationRepository.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import Foundation

final class AuthenticationRepository {
//    creamos una propiedad e instancia del DataSource
    private let authenticationFirebaseDataSource: AuthenticationFireBaseDataSource
    
    init(authenticationFirebaseDataSource: AuthenticationFireBaseDataSource = AuthenticationFireBaseDataSource()) {
        self.authenticationFirebaseDataSource = authenticationFirebaseDataSource
    }
    
    //    obtener la sesión actual del usuario
    func getCurrentUser() -> User? {
        authenticationFirebaseDataSource.getCurrentUser()
    }
    
//    creamos el metodo para crear el nuevo usuario de DataSourece
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDataSource.createNewUser(email: email,
                                                       password: password,
                                                       completionBlock: completionBlock)
    }
    
//    Iniciar sesión
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDataSource.login(email: email,
                                               password: password,
                                               completionBlock: completionBlock)
    }

//    Iniciar sesión con Facebook registrando el token
    func loginWithFacebook(completionBlock: @escaping (Result<User, Error>) -> Void ){
        authenticationFirebaseDataSource.loginWithFacebook(completionBlock: completionBlock)
    }
    
//    para cerrar sesión
    func logout() throws {
        try authenticationFirebaseDataSource.logout()
    }
    
//    obtener todos los proveedores con el mismo email
    func getCurrentProvider() -> [LinkedAccounts] {
        authenticationFirebaseDataSource.currentProvider()
    }
    
//    Vincular la cuenta de Facebook
    func linkFaceook(completionBlock: @escaping (Bool) -> Void) {
        authenticationFirebaseDataSource.linkFaceook(completionBlock: completionBlock)
    }
    
}
