//
//  FriendsTableViewCell.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 08/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarView: UIView!
    
    // MARK: - INIT
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.layer.cornerRadius = avatarView.bounds.width * 0.5
    }

}
