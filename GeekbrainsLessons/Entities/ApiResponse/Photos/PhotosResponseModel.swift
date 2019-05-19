//
//  PhotosResponseModel.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 07/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class PhotosResponseModel: Decodable {
    
    // MARK: - PROPERTIES
    
    let count: Int?
    let items: [PhotoResponseModel]
    
    // MARK: - KEYS
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: BaseCodingKeys.self)
        let container = try baseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        count = try container.decode(Int?.self, forKey: .count)
        items = (try? container.decode([PhotoResponseModel].self, forKey: .items)) ?? []
    }
    
}
