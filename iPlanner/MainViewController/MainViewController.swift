//
//  MainViewController.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit
import Contacts

class MainViewController: UIViewController {

    let cellIdentifier = "MainTableViewCell"
    let headerID = "TableHeaderView"
    let headerHeight = 30
    
    var sections: [String] = ["Избранное", "Контакты", "Действия"]
    var favorites: [Contact] = []
    var contacts: [Contact] = []
    var actions: [ActionType] = [ActionType(typeName: "Купить", identifier: "Купить", actions: nil),
                                     ActionType(typeName: "Подарить", identifier: "Подарить", actions: nil),
                                     ActionType(typeName: "Сделать", identifier: "Сделать", actions: nil)]
    let defaultActions = ["Купить", "Подарить", "Сделать"]
    let sectionHideAnimation = UITableView.RowAnimation.fade
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        contacts = ContactManager.shared.getContacts()
        setupTable()
    }
    
    func setupTable() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    }
    
    func getHeightForTableCell(_ section: Int) -> Int {
        return (Int(UIScreen.main.bounds.height) / sections.count) - sections.count * headerHeight
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0 && favorites.isEmpty) || (section == 1 && contacts.isEmpty) || (section == 2 && actions.isEmpty) { return 0 }
        else { return 1 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
            case 0:
                cell.setup(content: favorites, contentType: .contact)
            case 1:
                cell.setup(content: contacts, contentType: .contact)
            case 2:
                cell.setup(content: actions, contentType: .action)
            default:
                print("Something goes wrong with content type!")
                cell.setup(content: contacts, contentType: .contact)
        }
        cell.parentViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(getHeightForTableCell(indexPath.section))
        guard let cell = tableView.cellForRow(at: indexPath) else { return height }
        if cell.isHidden {
            return 0
        }
        return height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? TableHeaderView else {
            return UITableViewHeaderFooterView()
        }
        header.setup(title: sections[section])
        return header
    }
}

