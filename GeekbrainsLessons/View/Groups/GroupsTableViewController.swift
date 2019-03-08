//
//  GroupsTableViewController.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 04/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    
    var groups: [Group] = []
    
    private let addGroupVCSegueIdentifier = "AddGroupVCSegueIdentifier"
    private let cellIdentifier = "GroupsCell"
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - CONFIGURE
    
    func configure() {
        let firstGroup = Group(name: "first group", avatarColor: .orange)
        let secondGroup = Group(name: "second group", avatarColor: .red)
        let thirdGroup = Group(name: "third group", avatarColor: .yellow)
        let fourthGroup = Group(name: "fourth group", avatarColor: .orange)
        groups = [firstGroup, secondGroup, thirdGroup, fourthGroup]
        
        tableView.reloadData()
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
        
        let friend = groups[indexPath.row]
        cell.nameLabel.text = friend.name
        cell.avatarView.backgroundColor = friend.avatarColor
        
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
