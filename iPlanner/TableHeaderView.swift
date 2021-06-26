//
//  TableHeaderView.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var title: UILabel!
    
    func setup(title: String) {
        self.title.text = title
        self.title.font = UIFont.boldSystemFont(ofSize: 24.0)
//        self.backgroundColor = UIColor.clear
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
