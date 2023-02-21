//
//  DismissView.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 21/02/23.
//

import SwiftUI

struct DismissView: View {
//    para saber la vista que se a presentado y la cual dismissearemos
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button("Cerrar") {
                dismiss()
            }
            .tint(.black)
            .padding(.trailing, 12)
        }
        .buttonStyle(.bordered)
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
