//
//  MainCollectionViewCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(title: String) {
        button.setTitle(title, for: .normal)
    }
}
