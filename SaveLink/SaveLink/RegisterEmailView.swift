//
//  RegisterEmailView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        VStack {
            DismissView()
                .padding(.top, 8)
            Group {
                Text("Bienvenido")
                Text("Registrate")
                    .bold()
                    .underline()
            }
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            Group {
                Text("Registrate para guardar todos tus enlasces en una app")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                TextField("Ingresa tu correo electronico", text: $textFieldEmail)
                TextField("Ingresa tu contrasena", text: $textFieldPassword)
                Button("Aceptar") {
                    print("Aceptar")
                }
                .padding(.top, 18)
                .buttonStyle(.bordered)
                .tint(.blue)
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 64)
            Spacer()
        }
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView()
    }
}
