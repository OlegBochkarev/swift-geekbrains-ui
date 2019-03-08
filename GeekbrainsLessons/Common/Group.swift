//
//  Group.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 08/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

class Group {
    
    // MARK: - PROPERTIES
    
    var name: String = ""
    var avatarColor: UIColor = .gray
    
    // MARK: - INIT
    
    init(name: String, avatarColor: UIColor) {
        self.name = name
        self.avatarColor = avatarColor
    }
    
}
