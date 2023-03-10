//
//  HomeView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 22/02/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @StateObject var linkViewModel: LinkViewModel = LinkViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Text("Bienvenido \(authenticationViewModel.user?.email ?? "No usuario")")
                        .padding(.top, 32)
                    Spacer()
                    LinkView(linkViewModel: linkViewModel)
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                ProfileView(authenticationViewModel: authenticationViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("LogOut") {
                    authenticationViewModel.logout()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authenticationViewModel: AuthenticationViewModel())
    }
}
