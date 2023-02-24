//
//  LinkDataSource.swift
//  SaveLink
//
//  Created by YeltsinMacPro13 on 23/02/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//Modelo del dominio con las mismas propiedades de la base de datos en Firebase
struct LinkModel: Decodable, Identifiable, Encodable {
    @DocumentID var id: String? // indicamos que transforme el ID del documento de Firebase a nuestra propiedad ID
    let url: String
    let title: String
    let isFavorited: Bool
    let isCompleted: Bool
}

final class LinkDataSource {
    
    private let dataBase = Firestore.firestore() // Conexión a la base de datos
    private let collection = "links" // nombre de la colección creada en Firebase
    
//    obtenemos todos los links o un error
    func getAllLinks(completionsBlock: @escaping (Result<[LinkModel],Error>) -> Void) {
        dataBase.collection(collection)
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error al obtener los links: \(error.localizedDescription)")
                    completionsBlock(.failure(error))
                    return
                }
//                obtenemos los documentos
                guard let documents = query?.documents
                                            .compactMap({$0}) //evitar que obtengamos los nil
                else {
                    completionsBlock(.success([]))
                    return
                }
//                si existen documentos los extraemos para mapearlo a la struct
                let links = documents.map { try? $0.data(as: LinkModel.self) }
                    .compactMap { $0 } //evitar que obtengamos los nil
                completionsBlock(.success(links))
                
            }
    }
    
//    crear nueva informacion en la bd
    func createNewLink(link: LinkModel, completionsBlock: @escaping (Result<LinkModel,Error>) -> Void) {
        do {
//            guarda la informacion el la bd de firebase
            _ = try dataBase.collection(collection).addDocument(from: link)
            completionsBlock(.success(link))
        } catch {
            completionsBlock(.failure(error))
        }
    }
    
}
