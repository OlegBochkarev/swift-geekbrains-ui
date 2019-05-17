//
//  PhotoSizeRealmModel.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 17/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import RealmSwift

final class PhotoSizeRealmModel: Object {
    
    @objc dynamic var identifier: String? //id нет в Api. Создаем сами
    @objc dynamic var type: String?
    @objc dynamic var url: String?
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
}
