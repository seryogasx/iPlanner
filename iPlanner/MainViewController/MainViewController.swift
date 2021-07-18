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

struct TableSection {
    var item: String
    var isVisible: Bool
}

class MainViewController: UIViewController {

    let cellIdentifier = "MainTableViewCell"
    let headerID = "TableHeaderView"
    let headerHeight = 30
    
    var sections: [TableSection] = [TableSection(item: "Избранное", isVisible: true), TableSection(item: "Контакты", isVisible: true), TableSection(item: "Действия", isVisible: true)]
    var favorites: [String] = []
    var contacts: [String] = []
    var actions: [String] = ["Купить", "Подарить"]
    let sectionHideAnimation = UITableView.RowAnimation.fade
    
    @IBOutlet weak var tableView: UITableView!
    
    private func getContacts() {
        
        var contactsArray = Array<Contact>()
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
                        contactsArray.append(Contact(firstname: contact.givenName, secondName: contact.familyName, company: contact.organizationName))
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
        if sections[section].isVisible { return 1}
        else { return 0 }
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
        return CGFloat(getHeightForTableCell(indexPath.section))
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
        header.setup(title: sections[section].item)
        if section == 0 { header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(header0Clicked))) }
        else if section == 1 { header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(header1Clicked))) }
        else { header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(header2Clicked))) }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @objc func header0Clicked() {
        if let tableView = tableView {
            sections[0].isVisible = !sections[0].isVisible
            tableView.reloadSections(IndexSet(integer: 0), with: sectionHideAnimation
            )
        }
    }
    
    @objc func header1Clicked() {
        if let tableView = tableView {
            sections[1].isVisible = !sections[1].isVisible
            tableView.reloadSections(IndexSet(integer: 1), with: sectionHideAnimation)
        }
    }
    
    @objc func header2Clicked() {
        if let tableView = tableView {
            sections[2].isVisible = !sections[2].isVisible
            tableView.reloadSections(IndexSet(integer: 2), with: sectionHideAnimation)
        }
    }
}
