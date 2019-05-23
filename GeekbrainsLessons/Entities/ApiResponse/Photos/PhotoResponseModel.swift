//
//  Photo.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 07/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class PhotoResponseModel: Decodable {
    
    // MARK: - PROPERTIES
    
    let identifier: Int
    let ownerId: Int
    let userId: Int
    let sizes: [PhotoSizeResponseModel]
    
    // MARK: - KEYS
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case ownerId = "owner_id"
        case userId = "user_id"
        case sizes
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(Int.self, forKey: .identifier)
        ownerId = (try? container.decode(Int.self, forKey: .ownerId)) ?? -1
        userId = (try? container.decode(Int.self, forKey: .userId)) ?? -1
        sizes = (try? container.decode([PhotoSizeResponseModel].self, forKey: .sizes)) ?? []
    }
    
}
