//
//  ProfileView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var expandVerificationWithEmailForm: Bool = false
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        Form {
            Section {
                Button {
                    print("Vincular Email y Password")
                    expandVerificationWithEmailForm.toggle()
                } label: {
                    Label("Vincular Email", systemImage: "envelope.fill")
                }
                .disabled(authenticationViewModel.isEmailAndPasswordLinked())
                if expandVerificationWithEmailForm {
                    Group {
                        Text("Vincula tu correo electronico con tu cuenta actual")
                            .tint(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                        TextField("Ingresa tu correo electronico", text: $textFieldEmail)
                        TextField("Ingresa tu contrasena", text: $textFieldPassword)
                        Button("Aceptar") {
                            authenticationViewModel.linkEmailAndPassword(email: textFieldEmail, password: textFieldPassword)
                        }
                        .padding(.top, 18)
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        if let messageError =  authenticationViewModel.messageError {
                            Text(messageError)
                                .bold()
                                .font(.body)
                                .foregroundColor(.red)
                                .padding(.top, 20)
                        }
                    }
                }
                
                Button {
                    print("Vincular Facebook")
                    authenticationViewModel.linkFaceook()
                } label: {
                    HStack{
                        Image("facebook")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 4)
                        Text("Vincular Facebook")
                            .padding(.leading, 10)
                    }
                }
                .disabled(authenticationViewModel.isFacebookLinked())
            } header: {
                Text("Vincular otras cuentas a la sesión actual")
            }
        }
        .task {
            authenticationViewModel.getCurrentProvider()
        }
        .alert(authenticationViewModel.isAccountLinked ? "Cuenta Vinculada" : "Error",
               isPresented: $authenticationViewModel.showAlert) {
            Button("Aceptar"){
                print("Cerrar Alert")
//                ocultamos el formulario de vincular cuenta por email y password
                if authenticationViewModel.isAccountLinked {
                    expandVerificationWithEmailForm = false
                }
            }
        } message: {
            Text(authenticationViewModel.isAccountLinked ? "Acabas de vincular tu cuenta": "Error al vincular la cuenta")
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authenticationViewModel: AuthenticationViewModel())
    }
}
