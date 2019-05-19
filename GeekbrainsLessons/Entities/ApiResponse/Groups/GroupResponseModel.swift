//
//  Group.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 07/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

final class GroupResponseModel: Decodable {
    
    // MARK: - PROPERTIES
    
    let identifier: Int
    let name: String?
    let photo: String?
    
    // MARK: - KEYS
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case photo = "photo_200"
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(Int.self, forKey: .identifier)
        name = try? container.decode(String.self, forKey: .name)
        photo = try? container.decode(String.self, forKey: .photo)
    }
    
}
