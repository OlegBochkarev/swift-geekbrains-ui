//
//  UserRealmModel.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 17/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import RealmSwift

final class UserRealmModel: Object {
    
    @objc dynamic var identifier: Int = 0
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var domain: String?//ссылка на пользователя внутри вк
    @objc dynamic var photo: String?
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    //этот метод добавлен для простоты
    func update(withResponseModel responseModel: UserResponseModel) {
        identifier = responseModel.identifier
        firstName = responseModel.firstName
        lastName = responseModel.lastName
        domain = responseModel.domain
        photo = responseModel.photo
    }
    
}
