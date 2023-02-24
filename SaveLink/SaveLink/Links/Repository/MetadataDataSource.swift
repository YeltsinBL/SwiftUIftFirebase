//
//  MetadataDataSource.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import Foundation
import LinkPresentation

enum CustomMetadataError: Error {
case badURL
}

final class MetadataDataSource {
    private var metadataProvider: LPMetadataProvider?
    
    func getMetadata(fromURL url: String, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
//        convertimos la URL de tipo String a tipo URL
        guard let url = URL(string: url) else {
            completionBlock(.failure(CustomMetadataError.badURL))
            return
        }
        
//        instanciamos
        metadataProvider = LPMetadataProvider()
//        obtenemos la información de la URL
        metadataProvider?.startFetchingMetadata(for: url, completionHandler: { metadata, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            
            let linkModel = LinkModel(url: url.absoluteString, title: metadata?.title ?? "Sin titulo", isFavorited: false, isCompleted: false)
            completionBlock(.success(linkModel))
            
        })
    }
    
}
