//
//  Session.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 28/04/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    var toket: String? //для хранения токена в VK,
    var userId: Int? //для хранения идентификатора пользователя ВК.
    
    private init() {
        
    }
    
}
