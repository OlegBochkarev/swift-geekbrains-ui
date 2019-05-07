//
//  User.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 07/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class User: Decodable {
    
    // MARK: - PROPERTIES
    
    let identifier: Int
    let firstName: String?
    let lastName: String?
    let domain: String?//ссылка на пользователя внутри вк
    let photo: String?
    
    // MARK: - KEYS
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case domain
        case photo = "photo_200_orig"
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(Int.self, forKey: .identifier)
        firstName = try? container.decode(String.self, forKey: .firstName)
        lastName = try? container.decode(String.self, forKey: .lastName)
        domain = try? container.decode(String.self, forKey: .domain)
        photo = try? container.decode(String.self, forKey: .photo)
    }
    
}
