//
//  DataStorage.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 19/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import RealmSwift

class DataStorage {
    
    //DATA STORAGE IS SINGLETON
    static let shared = DataStorage()
    
    private init() {
        
    }
}

// MARK: - DataStorageProtocol

extension DataStorage: DataStorageProtocol {
    
    // MARK: - SAVE
    
    func saveFriends(_ friends: [UserResponseModel]) throws {
        if friends.isEmpty {
            return
        }
        var friendsRealmModels: [UserRealmModel] = []
        for friend in friends {
            let friendRealmModel = UserRealmModel()
            friendRealmModel.update(withResponseModel: friend)
            friendsRealmModels.append(friendRealmModel)
        }
        let realm = try Realm()
        try realm.write {
            realm.add(friendsRealmModels, update: true)
        }
    }
    
    // MARK: - FETCH
    
    func fetchFriends() -> [User] {
        let realm = try! Realm()
        let usersRealmModel = realm.objects(UserRealmModel.self)
        var friends: [User] = []
        for userRealmModel in usersRealmModel {
            let friend = User(realmModel: userRealmModel)
            friends.append(friend)
        }
        return friends
    }
    
    // MARK: - DELETE
    
    func deleteAll() {
        guard let realm = try? Realm() else {
            return
        }
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
