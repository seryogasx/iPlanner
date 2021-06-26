//
//  MainScreenCollectionViewCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 24.06.2021.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.text = "hello"
    }

}
