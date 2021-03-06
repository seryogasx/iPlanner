//
//  DetailViewController.swift
//  iPlanner
//
//  Created by Сергей Петров on 18.07.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var mainHeader: Content!
    var content: [Content] = []
    var contentType: ContentType?
    let cellIdentifier = "DetailVCCell"
    let headerCellIdentifier = "HeaderVCCell"
    let addContentCellIdentifier = "AddContentTableViewCellIdentifier"
    var headers: Array<String> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
        tableView.register(UINib(nibName: "AddContentTableViewCell", bundle: nil), forCellReuseIdentifier: addContentCellIdentifier)
    }

    func setup(content: Content?, contentType: ContentType) {
        self.mainHeader = content
        self.contentType = contentType
        if contentType == .contact {
            getContactData(contact: mainHeader as! Contact)
        } else {
            getActionData(action: mainHeader as! ActionType)
        }
    }
    
    func getContactData(contact: Contact) {
        
    }
    
    func getActionData(action: ActionType) {
        
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

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier, for: indexPath) as? HeaderCell else {
                    return UITableViewCell()
                }
                cell.setup(content: mainHeader, contentType: contentType!, contentImage: UIImage(named: "Applelogo")!)
                return cell
            case content.count:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: addContentCellIdentifier, for: indexPath) as? AddContentTableViewCell else {
                    return UITableViewCell()
                }
                cell.setup()
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DetailCell else {
                    return UITableViewCell()
                }
                if contentType == .contact {
                    cell.setup(content: content[indexPath.item - 1] as! Contact, contentType: contentType!)
                }
                else {
                    cell.setup(content: content[indexPath.item - 1] as! Action, contentType: contentType!)
                }
                return cell
        }
    }
    
}
