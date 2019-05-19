//
//  FriendsTableViewController.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 04/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    
    private let vkService = VKService(userId: Session.shared.userId!,
                                      token: Session.shared.token!)
    
    var friends: [User] = []
    
    private let friendVCSegueIdentifier = "FriendVCSegueIdentifier"
    private let cellIdentifier = "FriendsCell"
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadFriends()
    }
    
    // MARK: - CONFIGURE
    
    func configure() {
        
    }
    
    // MARK: - LOAD
    
    func loadFriends() {
        vkService.friends(withUserId: Session.shared.userId!)
        .done { responseModels in
            self.friends = responseModels
            self.tableView.reloadData()
        }.catch { error in
            print("loadFriends error = \(error.localizedDescription)")
            //делаем logout если получили ошибку.
            //я понимаю, что на любую ошибку не нужно делать логаут, но сейчас иногда бывает,
            //что токен уже не работает, и отличать эту ситуацию от прочих пока не хочется.
            //для простоты возвращаюсь на экран авторизации
            RootRouter().presentAuthorizationScreen()
        }
    }
    
    // MARK: - NAVIGATION
    
    func showFriendProfile(_ friend: User) {
        performSegue(withIdentifier: friendVCSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendVC = segue.destination as? FriendCollectionViewController,
            let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            
            friendVC.friend = friends[indexPathForSelectedRow.row]
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FriendsTableViewCell
        
        let friend = friends[indexPath.row]
        cell.model = friend
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if friends.count > 1 {
            return true
        } else {
            return false
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        showFriendProfile(friend)
    }
}
