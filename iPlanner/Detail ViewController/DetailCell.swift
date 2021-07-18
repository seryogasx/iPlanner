//
//  DetailCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 18.07.2021.
//

import UIKit

class DetailCell: UITableViewCell {

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
    
    func setup() {
        label.text = "hello"
        button.titleLabel?.text = "some text"
    }
    
}
