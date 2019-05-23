//
//  GroupsTableViewController.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 04/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    
    private let vkService = VKService(userId: Session.shared.userId!,
                                      token: Session.shared.token!)
    private let dataStorage: DataStorageProtocol = DataStorage.shared
    
    var groups: [Group] = []
    var groupsToken: NotificationToken?
    
    private let addGroupVCSegueIdentifier = "AddGroupVCSegueIdentifier"
    private let cellIdentifier = "GroupsCell"
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadGroups()
//        loadGroups(withQuery: "аниме")
    }
    
    // MARK: - CONFIGURE
    
    func configure() {
        let groupsResult = self.dataStorage.fetchGroups()
        groups = groupsResult.map({ Group(realmModel: $0) })
        tableView.reloadData()
        
        groupsToken = groupsResult.observe { [weak self] changes in
            switch changes {
            case .initial(let results):
                print("initial groups")
                self?.groups = results.map({ Group(realmModel: $0) })
                self?.tableView.reloadData()
            case let .update(results, deletions, insertions, modifications):
                print("update groups")
                self?.groups = results.map({ Group(realmModel: $0) })
                self?.tableView.performBatchUpdates({
                    self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                }, completion: nil)
            case .error(let error):
                print(error)
            }
            print("Groups данные изменились")
        }
    }
    
    // MARK: - LOAD
    
    func loadGroups() {
        print("loadGroups")
        vkService.groups(withUserId: Session.shared.userId!)
        .done { responseModels in
            try self.dataStorage.saveGroups(responseModels)
        }.catch { error in
            print("loadGroups error = \(error.localizedDescription)")
        }
    }
    
    func loadGroups(withQuery q: String) {
        vkService.searchGroups(withQuery: q)
        .done { responseModels in
            //я не думаю, что такие запросы нужно сохранять
            var groups: [Group] = []
            for responseModel in responseModels {
                let group = Group(responseModel: responseModel)
                groups.append(group)
            }
            self.groups = groups
            self.tableView.reloadData()
        }.catch { error in
            print("loadGroups withQuery = \(q); error = \(error.localizedDescription)")
        }
    }
    
    // MARK: - NAVIGATION
    
    @IBAction func addGroupButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: addGroupVCSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendVC = segue.destination as? GroupsAddTableViewController {
            friendVC.delegate = self
        }
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GroupsTableViewCell
        
        let group = groups[indexPath.row]
        cell.model = group
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if groups.count > 1 {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - GroupsAddTableViewControllerDelegate

extension GroupsTableViewController: GroupsAddTableViewControllerDelegate {
    func addGroup(_ group: Group) {
        groups.append(group)
        tableView.reloadData()
    }
}
