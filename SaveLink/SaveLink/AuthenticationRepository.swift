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
//    creamos el metodo para crear el nuevo usuario de DataSourece
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDataSource.createNewUser(email: email,
                                                       password: password,
                                                       completionBlock: completionBlock)
    }
}
