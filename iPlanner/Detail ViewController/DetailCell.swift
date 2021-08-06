//
//  DetailCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 18.07.2021.
//

import UIKit

class DetailCell: UITableViewCell {

    var content: UserContent?
    var contentType: ContentType?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(content: Content, contentType: ContentType) {
        self.contentType = contentType
        if self.contentType == .contact {
            label.text = ContactManager.shared.getContactInfo(contact: content as! Contact).fullName
        }
        else {
            label.text = (content as! UserAction).actionType.typeName
        }
        button.setTitle("some text", for: .normal)
    }
    
}
