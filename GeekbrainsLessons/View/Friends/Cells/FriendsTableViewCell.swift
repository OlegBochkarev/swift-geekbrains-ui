//
//  FriendsTableViewCell.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 08/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var model: User? {
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
        firstNameLabel.text = model.firstName
        lastNameLabel.text = model.lastName
        
        let avatarPlaceholder = UIImage(named: "friend_avatar_placeholder")
        avatarImageView.image = avatarPlaceholder
        if let avatarURLString = model.photo, let avatarURL = URL(string: avatarURLString) {
            let filePath = self.getDocumentsDirectory().appendingPathComponent("\(avatarURL.hashValue).jpg").path
            if FileManager.default.fileExists(atPath: filePath) {
                print("has image with url = \(avatarURLString)")
                avatarImageView.image = UIImage(contentsOfFile: filePath)
            } else {
                downloadImage(from: avatarURL)
            }
//            avatarImageView.kf.setImage(with: avatarURL, placeholder: avatarPlaceholder)
        }
    }
    
    // MARK: - HELPERS
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.avatarImageView.image = UIImage(data: data)
                if let filename = self?.getDocumentsDirectory().appendingPathComponent("\(url.hashValue).jpg") {
                    try? data.write(to: filename)
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
