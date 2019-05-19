//
//  Group.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class Group {
    
    let identifier: Int
    let name: String?
    let photo: String?
    
    init(realmModel: GroupRealmModel) {
        identifier = realmModel.identifier
        name = realmModel.name
        photo = realmModel.photo
    }
    
    init(responseModel: GroupResponseModel) {
        identifier = responseModel.identifier
        name = responseModel.name
        photo = responseModel.photo
    }
    
}
