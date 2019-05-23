//
//  FriendCollectionViewController.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 04/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit
import RealmSwift

class FriendCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - PROPERTIES
    
    private let vkService = VKService(userId: Session.shared.userId!,
                                      token: Session.shared.token!)
    private let dataStorage: DataStorageProtocol = DataStorage.shared
    
    var friend: User!
    
    var photos: [Photo] = []
    var photosToken: NotificationToken?
    
    private let reuseIdentifier = "FriendCell"
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = friend.firstName
        loadPhotos()
    }
    
    // MARK: - CONFIGURE
    
    func configure() {
        let photosResult = dataStorage.fetchPhotos(withOwnerId: friend.identifier)
        photos = photosResult.map({ Photo(realmModel: $0) })
        collectionView.reloadData()

        photosToken = photosResult.observe { [weak self] changes in
            switch changes {
            case .initial(let results):
                print("initial \(results)")
                self?.photos = results.map({ Photo(realmModel: $0) })
                self?.collectionView.reloadData()
            case let .update(results, deletions, insertions, modifications):
                print("update \(results)")
                self?.photos = results.map({ Photo(realmModel: $0) })
                self?.collectionView.performBatchUpdates({
                    self?.collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }) )
                    self?.collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}) )
                    self?.collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }) )
                }, completion: nil)
            case .error(let error):
                print(error)
            }
            print("данные изменились")
        }
    }
    
    // MARK: - LOAD
    
    func loadPhotos() {
        print("loadPhotos")
        let ownerId = friend.identifier
        vkService.photos(withOwnerId: ownerId)
        .done { responseModels in
            try self.dataStorage.savePhotos(responseModels)
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
