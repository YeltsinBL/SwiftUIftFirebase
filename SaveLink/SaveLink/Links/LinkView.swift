//
//  LinkView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import SwiftUI

struct LinkView: View {
    
    @ObservedObject var linkViewModel: LinkViewModel
    
    var body: some View {
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
            }
        }
        .task {
            linkViewModel.getAllLinks()
        }
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(linkViewModel: LinkViewModel())
    }
}
