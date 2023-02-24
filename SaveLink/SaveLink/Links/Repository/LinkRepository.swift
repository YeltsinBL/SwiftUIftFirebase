//
//  LinkRepository.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import Foundation

final class LinkRepository {
    private let linkDatasource: LinkDataSource
    
    init(linkDatasource: LinkDataSource = LinkDataSource()) {
        self.linkDatasource = linkDatasource
    }
    
//    obtenemos todos los links o un error
    func getAllLinks(completionsBlock: @escaping (Result<[LinkModel],Error>) -> Void) {
        linkDatasource.getAllLinks(completionsBlock: completionsBlock)
    }
    
}
