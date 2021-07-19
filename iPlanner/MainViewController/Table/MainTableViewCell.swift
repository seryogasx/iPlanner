//
//  MainTableViewCell.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit

enum ContentType {
    case contact
    case action
}

let maxTableViewCellHeight = UIScreen.main.bounds.height / 3

class MainTableViewCell: UITableViewCell {
    
    let cellIdentifier = "MainCollectionViewCell"
    var content: Array<String> = []
    var contentType: ContentType?
    var size = CGSize()
    
    var colors = [UIColor.red, UIColor.blue, UIColor.brown, UIColor.green]
    unowned var parentViewController: UIViewController!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        let layout = GridLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setup(content: Array<String>, contentType: ContentType) {
        self.content = content
        self.contentType = contentType
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
        cell.button.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.setup(content: content[indexPath.item], contentType: contentType!)
        self.parentViewController.present(detailVC, animated: true, completion: nil)
    }
}

extension MainTableViewCell: UICollectionViewDelegate {

}

extension MainTableViewCell: GridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, widthForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let text = content[indexPath.item]
        let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 22)
        let calculatedSize = (text as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)], context: nil)
        return max(calculatedSize.width, 50)
    }
}