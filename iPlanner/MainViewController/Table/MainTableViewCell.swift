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
    var content: Array<Content> = []
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
    }
    
    func setup(content: Array<Content>, contentType: ContentType) {
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
        if contentType == .contact {
            cell.setup(title: ContactManager.shared.getContactInfo(contact: content[indexPath.item] as! Contact).fullName)
        } else {
            cell.setup(title: (content[indexPath.item] as! ActionType).typeName)
        }
        
        cell.button.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        if contentType == .contact {
            detailVC.setup(content: content[indexPath.item] as! Contact, contentType: contentType!)
        } else {
            detailVC.setup(content: content[indexPath.item] as! ActionType, contentType: contentType!)
        }
        self.parentViewController.present(detailVC, animated: true, completion: nil)
    }
}

extension MainTableViewCell: UICollectionViewDelegate {

}

extension MainTableViewCell: GridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, widthForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let text = (contentType == .contact) ? ContactManager.shared.getContactInfo(contact: content[indexPath.item] as! Contact).fullName : (content[indexPath.item] as! ActionType).typeName
        let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 22)
        let calculatedSize = (text as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)], context: nil)
        return max(calculatedSize.width, 50)
    }
}
