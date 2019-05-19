//
//  User.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class User {
    
    let identifier: Int
    let firstName: String?
    let lastName: String?
    let domain: String?//ссылка на пользователя внутри вк
    let photo: String?
    
    init(realmModel: UserRealmModel) {
        identifier = realmModel.identifier
        firstName = realmModel.firstName
        lastName = realmModel.lastName
        domain = realmModel.domain
        photo = realmModel.photo
    }
    
}
