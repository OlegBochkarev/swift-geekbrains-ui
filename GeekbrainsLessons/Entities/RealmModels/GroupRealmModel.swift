//
//  GroupRealmModel.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 17/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import RealmSwift

final class GroupRealmModel: Object {
    
    @objc dynamic var identifier: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var photo: String?
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    //этот метод добавлен для простоты
    func update(withResponseModel responseModel: GroupResponseModel) {
        identifier = responseModel.identifier
        name = responseModel.name
        photo = responseModel.photo
    }
}
