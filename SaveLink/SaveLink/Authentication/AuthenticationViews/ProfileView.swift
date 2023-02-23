//
//  ProfileView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        Form {
            Section {
                Button {
                    print("Vincular Email y Password")
                } label: {
                    Label("Vincular Email", systemImage: "envelope.fill")
                }
                .disabled(authenticationViewModel.isEmailAndPasswordLinked())
                Button {
                    print("Vincular Facebook")
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authenticationViewModel: AuthenticationViewModel())
    }
}
