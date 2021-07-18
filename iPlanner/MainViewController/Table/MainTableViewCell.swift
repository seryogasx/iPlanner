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
        cell.button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonClicked)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(content[indexPath.item])
        let DetailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        self.parentViewController.present(DetailVC, animated: true, completion: nil)
        print("wow!")
    }
    
    @objc func buttonClicked() {
//        let storyboard = UIStoryboard(name: "main", bundle: nil).
        self.parentViewController.present(DetailViewController(nibName: "DetailViewController", bundle: nil), animated: true, completion: nil)
//        self.parentViewController.present
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
