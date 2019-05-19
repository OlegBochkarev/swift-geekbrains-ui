//
//  FriendCollectionViewController.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 04/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

class FriendCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - PROPERTIES
    
    private let vkService = VKService(userId: Session.shared.userId!,
                                      token: Session.shared.token!)
    private let dataStorage: DataStorageProtocol = DataStorage.shared
    
    var friend: User!
    
    var photos: [Photo] = []
    
    private let reuseIdentifier = "FriendCell"
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = friend.firstName
        loadPhotos()
    }
    
    // MARK: - LOAD
    
    func loadPhotos() {
        let ownerId = friend.identifier
        vkService.photos(withOwnerId: ownerId)
        .done { responseModels in
            try self.dataStorage.savePhotos(responseModels)
            self.photos = self.dataStorage.fetchPhotos(withOwnerId: ownerId)
            self.collectionView.reloadData()
        }.catch { error in
            print("loadPhotos error = \(error.localizedDescription)")
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotoCollectionViewCell
    
        cell.model = photos[indexPath.row]
    
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.5, height: 150)
    }

}
