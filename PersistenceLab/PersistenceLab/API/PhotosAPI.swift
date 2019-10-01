//
//  PhotosAPI.swift
//  PersistenceLab
//
//  Created by albert coelho oliveira on 9/30/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct PhotosAPi{
    // MARK: - Static Properties
        
        static let manager = PhotosAPi()
        
        // MARK: - Instance Methods
        
        
        func getPhotos(urlStr: String?, completionHandler: @escaping (Result<[Photos], AppError>) -> ())  {
            var url = URL(string: "https://pixabay.com/api/?key=\(Secretes.key)")
            if let word = urlStr?.lowercased(){
            let newString = word.replacingOccurrences(of: " ", with: "%20")
                url = URL(string:"https://pixabay.com/api/?key=\(Secretes.key)&q=\(newString)")
            }
            
            NetworkHelper.manager.performDataTask(withUrl: url!, andMethod: .get) { (results) in
                switch results {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let data):
                    do {
                        let elementInfo = try Photos.decodePhotos(from: data)
                        completionHandler(.success(elementInfo))
                    }
                    catch {
                        completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                    }
                    
                }
            }
            
        }
        
        
        
        private init() {}
    }


