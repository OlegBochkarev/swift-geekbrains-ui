//
//  FriendPhotoCollectionViewCell.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 07/05/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit
import Kingfisher

class FriendPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var model: Photo? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - INIT
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
    }
    
    // MARK: - UPDATE
    
    private func updateViews() {
        guard let model = model else {
            return
        }
        
        let photoPlaceholder = UIImage(named: "friend_avatar_placeholder")
        if let photoModel = model.sizes.last, let avatarURLString = photoModel.url, let avatarURL = URL(string: avatarURLString) {
            photoImageView.kf.setImage(with: avatarURL, placeholder: photoPlaceholder)
        } else {
            photoImageView.image = photoPlaceholder
        }
    }
    
}
