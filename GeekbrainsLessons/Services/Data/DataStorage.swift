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
    
    func saveGroups(_ groups: [GroupResponseModel]) throws {
        if groups.isEmpty {
            return
        }
        var groupsRealmModels: [GroupRealmModel] = []
        for group in groups {
            let groupRealmModel = GroupRealmModel()
            groupRealmModel.update(withResponseModel: group)
            groupsRealmModels.append(groupRealmModel)
        }
        let realm = try Realm()
        try realm.write {
            realm.add(groupsRealmModels, update: true)
        }
    }
    
    func savePhotos(_ photos: [PhotoResponseModel]) throws {
        if photos.isEmpty {
            return
        }
        var photosRealmModels: [PhotoRealmModel] = []
        for photo in photos {
            let photoRealmModel = PhotoRealmModel()
            photoRealmModel.identifier = photo.identifier
            photoRealmModel.ownerId = photo.ownerId
            photoRealmModel.userId = photo.userId
            for photoSize in photo.sizes {
                let sizeRealmModel = PhotoSizeRealmModel()
                sizeRealmModel.identifier = "\(photo.identifier)+\(photoSize.width)+\(photoSize.height)"
                sizeRealmModel.type = photoSize.type
                sizeRealmModel.url = photoSize.url
                sizeRealmModel.width = photoSize.width
                sizeRealmModel.height = photoSize.height
                photoRealmModel.sizes.append(sizeRealmModel)
            }
            photosRealmModels.append(photoRealmModel)
        }
        let realm = try Realm()
        try realm.write {
            realm.add(photosRealmModels, update: true)
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
    
    func fetchGroups() -> [Group] {
        let realm = try! Realm()
        let groupsRealmModel = realm.objects(GroupRealmModel.self)
        var groups: [Group] = []
        for groupRealmModel in groupsRealmModel {
            let group = Group(realmModel: groupRealmModel)
            groups.append(group)
        }
        return groups
    }
    
    func fetchPhotos(withOwnerId ownerId: Int) -> [Photo] {
        let realm = try! Realm()
        let photosRealmModel = realm.objects(PhotoRealmModel.self).filter("ownerId = %d", ownerId)
        var photos: [Photo] = []
        for photoRealmModel in photosRealmModel {
            let photo = Photo(realmModel: photoRealmModel)
            photos.append(photo)
        }
        return photos
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
