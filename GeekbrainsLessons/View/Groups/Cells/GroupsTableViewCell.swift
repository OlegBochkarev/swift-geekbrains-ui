//
//  GroupsTableViewCell.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 08/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit
import Kingfisher

class GroupsTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var model: Group? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - INIT
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width * 0.5
    }
    
    // MARK: - UPDATE
    
    private func updateViews() {
        guard let model = model else {
            return
        }
        nameLabel.text = model.name
        
        let avatarPlaceholder = UIImage(named: "friend_avatar_placeholder")
        if let avatarURLString = model.photo, let avatarURL = URL(string: avatarURLString) {
            avatarImageView.kf.setImage(with: avatarURL, placeholder: avatarPlaceholder)
        } else {
            avatarImageView.image = avatarPlaceholder
        }
    }
    
}
