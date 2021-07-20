//
//  AddContentTableViewCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 20.07.2021.
//

import UIKit

class AddContentTableViewCell: UITableViewCell {

    @IBOutlet weak var addContentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        addContentButton.setTitle("Click here to add content", for: .normal)
    }
    
    @IBAction func addContentButtonClicked(_ sender: Any) {
        print("Add content!")
    }
}
