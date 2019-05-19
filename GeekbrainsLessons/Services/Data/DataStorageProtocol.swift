//
//  DataStorageProtocol.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

protocol DataStorageProtocol: class {
    func saveFriends(_ friends: [UserResponseModel]) throws
    
    func fetchFriends() -> [User]
    
    func deleteAll()
}
