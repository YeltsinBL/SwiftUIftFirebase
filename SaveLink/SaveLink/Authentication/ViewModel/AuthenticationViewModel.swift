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
//    para llenar las cuentas vinculadas
    @Published var linkedAccounds: [LinkedAccounts] = []
    
//    Vincular las cuentas
    @Published var showAlert: Bool = false
    @Published var isAccountLinked: Bool = false
    
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
    
//    Iniciar sesión
    func login(email: String, password: String) {
        authenticationRepository.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
//    Iniciar sesión con Facebook
    func loginWithFacebook() {
        authenticationRepository.loginWithFacebook { [weak self] result in
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
    
//    obtener todos los proveedores con el mismo email
    func getCurrentProvider() {
        linkedAccounds = authenticationRepository.getCurrentProvider()
        print("Cuentas Vinculadas \(linkedAccounds)")
    }
    
//    para habilitar o no los botones de las cuentas a vincular
    func isEmailAndPasswordLinked() -> Bool {
//        verificamos si tiene este ID de nombre
        linkedAccounds.contains(where: { $0.rawValue == "password" })
    }
    func isFacebookLinked() -> Bool {
        linkedAccounds.contains(where: { $0.rawValue == "facebook.com" })
    }
    
//    Vincular la cuenta de Facebook
    func linkFaceook() {
        authenticationRepository.linkFaceook { [weak self] isSuccess in
            print("Facebook Vinculado \(isSuccess.description)")
            self?.isAccountLinked = isSuccess
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
    
}
