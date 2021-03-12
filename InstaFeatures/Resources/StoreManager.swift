//
//  StoreManager.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 09/03/21.
//

import FirebaseStorage


public class StoreManager {
    static let shared = StoreManager()
    private let bucket = Storage.storage().reference()
    
    
    // MARK: public functions
    public func uploadUserPhotoPost(of: UserPost, completion: @escaping (Result<URL, Error>) -> Void){
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void){
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(IGStorageManagerError.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
    
    
}

public enum IGStorageManagerError: Error {
    case failedToDownload
}


