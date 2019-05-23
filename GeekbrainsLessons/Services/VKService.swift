//
//  VKService.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 30/04/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum PhotoAlbum: String {
    case wall
    case profile
    case saved
}

final class VKService {
    
    // MARK: - PROPERTIES
    
    private let userId: Int //id текущего пользователя
    private let token: String
    
    private let serverURL: String = "https://api.vk.com/method/"
    private let apiVersion = "5.95"
    
    //manager для отправки запросов
    private lazy var manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    var headers = ["Content-Type": "application/json"]
    
    // MARK: - INIT
    
    init(userId: Int, token: String) {
        self.userId = userId
        self.token = token
    }
    
    // MARK: - PRIVATE
    
    private func GET<T: Decodable>(_ urlString: String, parameters: Parameters?, responseType: T.Type) -> Promise<T> {
        return manager.request(urlString,
                               method: .get,
                               parameters: parameters,
                               encoding: URLEncoding.default,
                               headers: headers).validate().responseDecodable(T.self)
    }
    
    // MARK: - PUBLIC
    
    //userId - любого пользователя в вк
    func friends(withUserId userId: Int) -> Promise<[UserResponseModel]> {
        let urlString = serverURL + "friends.get"
        
        let parameters: Parameters = ["user_id": userId,
                                      "order": "hints",
                                      "count" : 20,
                                      "offset": 0,
                                      "fields": "photo_200_orig,domain",
                                      "name_case": "nom",
                                      "access_token": token,
                                      "v": apiVersion]
        
        return GET(urlString, parameters: parameters, responseType: FriendsResponseModel.self)
        .then { responseModel -> Promise<[UserResponseModel]> in
            return .value(responseModel.items)
        }
    }
    
    //идентификатор владельца альбома.
    //у сообществ отрицательное число
    func photos(withOwnerId ownerId: Int, album: PhotoAlbum = .profile) -> Promise<[PhotoResponseModel]> {
        let urlString = serverURL + "photos.get"
        
        let parameters: Parameters = ["owner_id": ownerId,
                                      "album_id": album.rawValue,
                                      "count" : 20,
                                      "offset": 0,
                                      "access_token": token,
                                      "v": apiVersion]
        
        return GET(urlString, parameters: parameters, responseType: PhotosResponseModel.self)
        .then { responseModel -> Promise<[PhotoResponseModel]> in
            return .value(responseModel.items)
        }
    }
    
    func groups(withUserId userId: Int) -> Promise<[GroupResponseModel]> {
        let urlString = serverURL + "groups.get"
        
        let parameters: Parameters = ["user_id": userId,
                                      "extended": 1,
                                      "count" : 20,
                                      "offset": 0,
                                      "access_token": token,
                                      "v": apiVersion]
        
        return GET(urlString, parameters: parameters, responseType: GroupsResponseModel.self)
        .then { responseModel -> Promise<[GroupResponseModel]> in
            return .value(responseModel.items)
        }
    }
    //глобальный поиск групп
    func searchGroups(withQuery q: String) -> Promise<[GroupResponseModel]> {
        let urlString = serverURL + "groups.search"
        
        let parameters: Parameters = ["q": q,
                                      "count" : 20,
                                      "offset": 0,
                                      "access_token": token,
                                      "v": apiVersion]
        
        return GET(urlString, parameters: parameters, responseType: GroupsResponseModel.self)
        .then { responseModel -> Promise<[GroupResponseModel]> in
            return .value(responseModel.items)
        }
    }
    
}
