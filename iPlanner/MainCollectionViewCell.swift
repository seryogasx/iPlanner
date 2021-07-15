//
//  MainCollectionViewCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    var buttonClickedAction: (() -> ())?
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(title: String) {
        button.setTitle(title, for: .normal)
        button.setButtonForm()
    }
    
    @IBAction func ButtonClicked(_ sender: UIButton) {
        print("Button has been pressed!")
        buttonClickedAction?()
    }
}

extension UIButton {
    func setButtonForm() {
        UIGraphicsBeginImageContext(layer.frame.size)
        
        let recPath = UIBezierPath(roundedRect: frame, byRoundingCorners: [.topLeft, .bottomRight, .topRight, .bottomLeft], cornerRadii: CGSize(width: 42, height: 42))
        UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1).setFill()
        recPath.fill()
        let imageBuffer = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        layer.contents = imageBuffer?.cgImage
        
        titleEdgeInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)
    }
}
