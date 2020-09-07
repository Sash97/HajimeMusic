//
//  FIRFirestoreService.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/31/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import Foundation
import FirebaseFirestore



enum NetworkError: String, Error {
    case encodingError = "Encoding is failed"
    case decogingError = "Decoding is failed"
    case ubsenceId     = "User id is ubsent"
    case emptySnapshot = "Snapshot is nil"
}

enum FIRCollectionReference: String {
    case music
}


protocol FirestoreService {
    func read<T: Decodable>(from collectionReference: FIRCollectionReference, returning objectType: T.Type, completion: @escaping([T]) -> Void)
}

class FIRFirestoreService: FirestoreService {
    
    //MARK: - Properties -
    
    static let shared = FIRFirestoreService()
    
    
    
    //MARK: - Init -
    
    private init() {}
    
    
    
    //MARK: - Requests -
    
    func read<T: Decodable>(from collectionReference: FIRCollectionReference, returning objectType: T.Type, completion: @escaping([T]) -> Void) {
        reference(to: collectionReference).addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            do {
                var objects = [T]()
                for document in snapshot.documents {
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                completion(objects)
            } catch {
                print(error)
            }
        }
    }
    
    
    //MARK: - Helpers -
    
    private func reference(to collectionReference: FIRCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
}


extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        var documentJson = data()
        if includingId {
            documentJson!["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson!, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
}
