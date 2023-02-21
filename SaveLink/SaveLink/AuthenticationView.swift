//
//  ContentView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import SwiftUI

enum AuthenticationSheetView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationView: View {
    
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View {
        VStack {
            Image("descarga")
                .resizable()
                .frame(width: 350, height: 250)
                .clipShape(Circle())
                .overlay(Circle()
                    .stroke(Color.blue,
                            lineWidth: 3))
            VStack {
                Button {
                    authenticationSheetView = .login
                } label: {
                    Label("Entra con Email", systemImage: "envelope.fill")
                }.tint(.black)

            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 60)
            Spacer()
            HStack {
                Button {
                    authenticationSheetView = .register
                } label: {
                    Text("No tienes cuenta?")
                    Text("Registrate")
                        .underline()
                }
                .tint(.black)

            }
        }
        .sheet(item: $authenticationSheetView) { sheet in
            switch sheet {
            case .register:
                RegisterEmailView()
            case .login:
                LoginEmailView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
