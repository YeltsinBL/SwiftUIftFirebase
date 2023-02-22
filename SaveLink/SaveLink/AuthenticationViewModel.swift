//
//  AuthenticationViewModel.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
//    para controlar si el usuario se a registrado de forma correcta o no
//    para mostrar mas informacion de lo ocurrido
    @Published var user: User?
    @Published var messageError: String?
    
    //    creamos una propiedad e instancia del Repository
    private let authenticationRepository: AuthenticationRepository
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser() // para que muestre si la sesión esta activa
    }
    
    //    obtener la sesion actual del usuario y pasarlo a la variable publica del usuario
    func getCurrentUser() {
        self.user = authenticationRepository.getCurrentUser()
    }
    
//    creamos el metodo de crear usuario que sera llamado desde la vista
    func createNewUser(email: String, password: String) {
        authenticationRepository.createNewUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
//    para cerrar sesión
    func logout() {
        do {
            try authenticationRepository.logout()
            self.user = nil
        }catch {
            print("Error logout")
        }
    }
    
}
