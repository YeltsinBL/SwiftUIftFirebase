//
//  LinkViewModel.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import Foundation

final class LinkViewModel: ObservableObject {
    
    @Published var links: [LinkModel] = []
    @Published var messageError: String?
    
    
    private let linkRepository: LinkRepository
    
    init(linkRepository: LinkRepository = LinkRepository()) {
        self.linkRepository = linkRepository
    }

//    obtenemos todos los links o un error
    func getAllLinks() {
        linkRepository.getAllLinks { [weak self] result in
            switch result {
            case .success(let linkModels):
                self?.links = linkModels
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
//    agregar la nueva información a la base de datos
    func createNewLink(withURL url: String) {
        linkRepository.createNewLink(withURL: url) { [weak self] result in
            switch result {
            case .success(let link):
//                asignamos la nueva información al array en memoria de la aplicación
//                self?.links.append(link)
//                al guardar en la bd no necesita ser agredado al array de la memoria porque se actualiza en tiempo real
                print("Nuevo link agregado: \(link.title)")
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
}