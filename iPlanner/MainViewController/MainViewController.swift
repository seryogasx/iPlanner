//
//  MainViewController.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit
import Contacts

struct Contact {
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
    
//    let sections = ["Избранное", "Контакты", "Действия"].sorted()
//    let favorites = ["Jenka"/*, "Kaban", "Koreya"*/].sorted()
//    let contacts = ["Jenka", "Ilyas", "Nekit", "Psina", "Lexaaaaa", "Kurlyk", "Kukarek"].sorted()
//    let actions = ["Подарок", "Купить"/*, "Позвонить", "Заплатить"*/].sorted()
    
    let sections: [String] = ["Избранное", "Контакты", "Действия"]
    var favorites: [String] = []
    var contacts: [String] = ["aa", "b", "ccc", "dddd", "eeeee", "fffffffffffffffffffffffffffffff"]
    var actions: [String] = ["Купить", "Подарить"]
    
    @IBOutlet weak var tableView: UITableView!
    
    private func getContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to access contacts!")
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactOrganizationNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request) { (contact, stopPointer) in
                        self.contacts.append(Contact(firstname: contact.givenName, secondName: contact.familyName, company: contact.organizationName).fullName)
                    }
                } catch let error {
                    print("failed to parse contacts!")
                }
            } else {
                print("access denied!")
            }
        }
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
        tableView.tableFooterView = UIView()
    }
    
    func getHeightForTableCell(_ section: Int) -> Int {
        return (Int(UIScreen.main.bounds.height) / 3) - 3 * headerHeight
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(content: indexPath.section == 0 ? favorites : indexPath.section == 1  ? contacts : actions)
        cell.parentViewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 && favorites.count < 3 {
//            return CGFloat(getHeightForTableCell(indexPath.section) * favorites.count / 3)
//        } else if indexPath.section == 1 && contacts.count < 3 {
//            return CGFloat(getHeightForTableCell(indexPath.section) * contacts.count / 3)
//        } else if indexPath.section == 2 && actions.count < 3 {
//            return CGFloat(getHeightForTableCell(indexPath.section) * actions.count / 3)
//        }
        return CGFloat(getHeightForTableCell(indexPath.section))
//        return UITableView.
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
