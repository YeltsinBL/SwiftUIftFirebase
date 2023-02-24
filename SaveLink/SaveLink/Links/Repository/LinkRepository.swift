//
//  LinkRepository.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import Foundation

final class LinkRepository {
    private let linkDatasource: LinkDataSource
    private let metadataDataSource: MetadataDataSource
    
    init(linkDatasource: LinkDataSource = LinkDataSource(),
         metadataDatasource: MetadataDataSource = MetadataDataSource()) {
        self.linkDatasource = linkDatasource
        self.metadataDataSource = metadataDatasource
    }
    
//    obtenemos todos los links o un error
    func getAllLinks(completionsBlock: @escaping (Result<[LinkModel],Error>) -> Void) {
        linkDatasource.getAllLinks(completionsBlock: completionsBlock)
    }
    
//    crear una nueva información
    func createNewLink(withURL url: String,
                       completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
//        metadataDataSource.getMetadata(fromURL: url, completionBlock: completionBlock)
        metadataDataSource.getMetadata(fromURL: url) { [weak self] result in
            switch result {
            case .success(let linkModel):
                self?.linkDatasource.createNewLink(link: linkModel, completionsBlock: completionBlock)
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
    
//    actualizar información de la BD
    func update(link: LinkModel) {
        linkDatasource.update(link: link)
    }
    
    
}
