//
//  PhotoRealmModel.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 17/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import RealmSwift

final class PhotoRealmModel: Object {
    
    @objc dynamic var identifier: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var userId: Int = 0
    let sizes = List<PhotoSizeRealmModel>()
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
}
