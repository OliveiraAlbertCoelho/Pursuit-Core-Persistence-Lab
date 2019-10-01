//
//  PicturesModel.swift
//  PersistenceLab
//
//  Created by albert coelho oliveira on 9/30/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct PhotosWrapper: Codable{
    let hits: [Photos]
}
struct Photos: Codable {
    let largeImageURL: String
    let id: Int
    let likes: Int
    let views: Int
    let tags: String
    
    static func decodePhotos(from data: Data) throws -> [Photos]{
        let response = try JSONDecoder().decode(PhotosWrapper.self, from: data)
        return response.hits
    }
}

