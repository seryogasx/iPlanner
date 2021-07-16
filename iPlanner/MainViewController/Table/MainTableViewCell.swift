//
//  MainTableViewCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit

let maxTableViewCellHeight = UIScreen.main.bounds.height / 3

class MainTableViewCell: UITableViewCell {
    
    let cellIdentifier = "MainCollectionViewCell"
    var content: Array<String> = []
    var size = CGSize()
    
    var colors = [UIColor.red, UIColor.blue, UIColor.brown, UIColor.green]
    unowned var parentViewController: UIViewController!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        let gridLayout = GridLayout()
        gridLayout.delegate = self
        collectionView.collectionViewLayout = gridLayout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(content: Array<String>) {
        self.content = content
    }
    
}


extension MainTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(title: content[indexPath.item])
        cell.buttonClickedAction = { [weak self] () in
            self?.parentViewController.present(DetailViewController(), animated: true, completion: nil)
        }
        return cell
    }
}

extension MainTableViewCell: UICollectionViewDelegate {

}

extension MainTableViewCell: GridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForGridAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 10.0
        let text = content[indexPath.item]
        let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 42)
        let calculatedSize = (text as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)], context: nil)
        return CGSize(width: calculatedSize.width + cellPadding, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52.0
    }
    
    func collectionView(_ collectionView: UICollectionView, insetsForItemsInSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemSpacingInSection section: Int) -> CGFloat {
        return 12.0
    }
}
