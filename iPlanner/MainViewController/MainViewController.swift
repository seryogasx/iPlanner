//
//  MainViewController.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit
import Contacts

struct UserContact {
    var firstname: String
    var secondName: String
    var company: String

    var count: Int {
        return firstname.count + secondName.count + company.count
    }
    var fullName: String {
        return firstname + " " + secondName
    }
}

class MainViewController: UIViewController {

    let cellIdentifier = "MainTableViewCell"
    let headerID = "TableHeaderView"
    let headerHeight = 30
    
    var sections: [String] = ["Избранное", "Контакты", "Действия"]
    var favorites: [String] = []
    var contacts: [String] = []
    var actions: [String] = ["Купить", "Подарить", "Сделать"]
    let sectionHideAnimation = UITableView.RowAnimation.fade
    
    @IBOutlet weak var tableView: UITableView!
    
    private func getContacts() {
        
        var contactsArray = Array<UserContact>()
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to access contacts! Description: \(error.localizedDescription)")
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactOrganizationNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request) { (contact, stopPointer) in
                        contactsArray.append(UserContact(firstname: contact.givenName, secondName: contact.familyName, company: contact.organizationName))
                    }
                } catch let error {
                    print("failed to parse contacts! Description: \(error.localizedDescription)")
                }
            } else {
                print("access denied!")
            }
        }
        contactsArray.sort { (first, second) in
            first.firstname != second.firstname ? first.firstname < second.firstname : first.secondName < second.secondName
        }
        contacts = contactsArray.map { $0.fullName }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        getContacts()
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

