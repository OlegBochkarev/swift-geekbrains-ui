//
//  DataStorageProtocol.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataStorageProtocol: class {
    func saveFriends(_ friends: [UserResponseModel]) throws
    func saveGroups(_ groups: [GroupResponseModel]) throws
    func savePhotos(_ photos: [PhotoResponseModel]) throws
    
    func fetchFriends() -> Results<UserRealmModel> // [User]
    func fetchGroups() -> [Group]
    func fetchPhotos(withOwnerId ownerId: Int) -> [Photo]
    
    func deleteAll()
}
