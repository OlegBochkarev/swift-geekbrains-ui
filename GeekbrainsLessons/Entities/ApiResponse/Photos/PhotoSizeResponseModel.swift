//
//  PhotoSizeModel.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 07/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import Foundation

final class PhotoSizeResponseModel: Decodable {
    
    // MARK: - PROPERTIES
    
    let type: String?
    let url: String?
    let width: Int
    let height: Int
    
    // MARK: - KEYS
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case width
        case height
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try? container.decode(String.self, forKey: .type)
        url = try? container.decode(String.self, forKey: .url)
        width = (try? container.decode(Int.self, forKey: .width)) ?? 0
        height = (try? container.decode(Int.self, forKey: .height)) ?? 0
    }
    
}
