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
        print("KEK")
        let layout = NotesCollectioinViewLayout()
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
        cell.buttonClickedAction = { [weak self] () in
            self?.parentViewController.present(DetailViewController(), animated: true, completion: nil)
        }
        return cell
    }
}

extension MainTableViewCell: UICollectionViewDelegate {
    
}

extension MainTableViewCell: NotesCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, widthAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(content[indexPath.item].count * 10)
    }
}
