//
//  HeaderCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 20.07.2021.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(title: String, contentImage: UIImage) {
        self.label.text = title
        imageHeight.constant = UIScreen.main.bounds.height / 8
        self.contentMode = .scaleAspectFit
        self.contentImage.image = contentImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
