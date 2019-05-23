//
//  PhotoSize.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class PhotoSize {
    
    let type: String?
    let url: String?
    let width: Int
    let height: Int
    
    init(realmModel: PhotoSizeRealmModel) {
        type = realmModel.type
        url = realmModel.url
        width = realmModel.width
        height = realmModel.height
    }
    
}
