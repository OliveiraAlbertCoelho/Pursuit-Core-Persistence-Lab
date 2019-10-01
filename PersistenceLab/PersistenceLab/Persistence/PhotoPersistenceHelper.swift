//
//  PhotoPersistenceHelper.swift
//  PersistenceLab
//
//  Created by albert coelho oliveira on 9/30/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

class PhotoPersistenceHelper {
    static let manager = PhotoPersistenceHelper()
    func savePhotos(newPhoto: Photos)throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    let persistenceHelper = PersistenceHelper<Photos>(fileName: "savedPhotos.plist")
    func getPhotos()throws -> [Photos]{
   return try persistenceHelper.getObjects()
    }
    private init(){}
}
