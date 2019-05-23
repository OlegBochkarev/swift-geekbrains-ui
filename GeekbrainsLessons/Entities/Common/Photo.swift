//
//  Photo.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class Photo {
    
    let identifier: Int
    let ownerId: Int
    let userId: Int
    let sizes: [PhotoSize]
    
    init(realmModel: PhotoRealmModel) {
        identifier = realmModel.identifier
        ownerId = realmModel.ownerId
        userId = realmModel.userId
        var sizes: [PhotoSize] = []
        for sizeRealmModel in realmModel.sizes {
            let size = PhotoSize(realmModel: sizeRealmModel)
            sizes.append(size)
        }
        self.sizes = sizes
    }
    
}
