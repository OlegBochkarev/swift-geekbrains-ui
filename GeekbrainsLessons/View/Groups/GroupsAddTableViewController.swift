//
//  GroupsAddTableViewController.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 04/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit

protocol GroupsAddTableViewControllerDelegate: class {
    func addGroup(_ group: Group)
}

class GroupsAddTableViewController: UITableViewController {
    
    // MARK: - PROPERTIES
    
    var groups: [Group] = []
    
    weak var delegate: GroupsAddTableViewControllerDelegate?
    
    private let cellIdentifier = "GroupAddCell"
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - CONFIGURE
    
    func configure() {
        let firstGroup = Group(name: "Group add 1", avatarColor: .green)
        let secondGroup = Group(name: "Group add 2", avatarColor: .gray)
        let thirdGroup = Group(name: "Group add 3", avatarColor: .black)
        groups = [firstGroup, secondGroup, thirdGroup]
        
        tableView.reloadData()
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
        cell.nameLabel.text = group.name
        cell.avatarView.backgroundColor = group.avatarColor
        
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
        let group = groups[indexPath.row]
        delegate?.addGroup(group)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
    }
}
