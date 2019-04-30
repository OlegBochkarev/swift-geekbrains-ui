//
//  VKService.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 30/04/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation
import Alamofire

final class VKService {
    
    // MARK: - PROPERTIES
    
    private let userId: Int
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
    
    // MARK: -
    
    func friends() {
        let urlString = serverURL + "friends.get"
        
        let parameters: Parameters = ["user_id": userId,
                                      "order": "hints",
                                      "count" : 20,
                                      "offset": 0,
                                      "fields": "photo_200_orig,domain",
                                      "name_case": "nom",
                                      "access_token": token,
                                      "v": apiVersion]
        manager.request(urlString,
                        method: .post,
                        parameters: parameters,
                        encoding: URLEncoding.default,
                        headers: headers).validate()
            .responseJSON { (response) in
                
                print("friends response = \(response)")
        }
    }
    
}
