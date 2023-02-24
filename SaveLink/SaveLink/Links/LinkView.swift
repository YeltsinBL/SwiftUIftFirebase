//
//  LinkView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import SwiftUI

struct LinkView: View {
    
    @ObservedObject var linkViewModel: LinkViewModel
    @State var text: String = ""
    @EnvironmentObject var remoteConfiguration: RemoteConfiguration
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .frame(height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.green, lineWidth: 2)
                }
                .padding(.horizontal, 12)
                .cornerRadius(3)
            Button {
                linkViewModel.createNewLink(withURL: text)
            } label: {
                Label(remoteConfiguration.buttonTitle, systemImage: "link")
            }
            .tint(.green)
            .controlSize(.regular)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            if (linkViewModel.messageError != nil) {
                Text(linkViewModel.messageError!)
                    .bold()
                    .foregroundColor(.red)
            }

            List {
                ForEach(linkViewModel.links) { link in
                    VStack {
                        Text(link.title)
                            .bold()
                            .lineLimit(4)
                            .padding(.bottom, 8)
                        Text(link.url)
                            .foregroundColor(.gray)
                            .font(.caption)
                        HStack {
                            Spacer()
                            if link.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .frame(width: 10, height: 10)
                            }
                            if link.isFavorited {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundColor(.yellow)
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            linkViewModel.updateIsFavorited(link: link)
                        } label: {
                            Label("Favorito", systemImage: "star.fill")
                        }
                        .tint(.yellow)
                        Button {
                            linkViewModel.updateIsCompleted(link: link)
                        } label: {
                            Label("Completado", systemImage: "checkmark.circle.fill")
                        }
                        .tint(.blue)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            linkViewModel.delete(link: link)
                        } label: {
                            Label("Eliminar", systemImage: "trash.fill")
                        }
                        .tint(.red)
                    }
                }
            }
            .task {
                remoteConfiguration.fetch()
                linkViewModel.getAllLinks()
            }
        }
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(linkViewModel: LinkViewModel())
    }
}
