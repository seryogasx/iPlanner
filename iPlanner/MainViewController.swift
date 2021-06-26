//
//  MainViewController.swift
//  iPlanner
//
//  Created by Сергей Петров on 26.06.2021.
//

import UIKit

class MainViewController: UIViewController {

    let cellIdentifier = "MainTableViewCell"
    let headerID = "TableHeaderView"
    let sections = ["Избранное", "Контакты", "Действия"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        setupTable()
    }
    
    func setupTable() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        tableView.tableFooterView = UIView()
    }
    
    func getHeightForTableCell() -> Int {
        return Int(UIScreen.main.bounds.height) / 3
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(size: CGSize(width: 100, height: 100), content: ["hello", "hi"])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(getHeightForTableCell())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? TableHeaderView else {
            return UITableViewHeaderFooterView()
        }
        header.setup(title: sections[section])
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

//class flow: UICollectionViewFlowLayout {
//
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else {
//            return nil
//        }
//
//        let sectionsToAdd = NSMutableIndexSet()
//        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
//
//        for layoutAttributesSet in layoutAttributes {
//            if layoutAttributesSet.representedElementCategory == .cell {
//                newLayoutAttributes.append(layoutAttributesSet)
//                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
//            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
//                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
//            }
//        }
//
//        for section in sectionsToAdd {
//            let indexPath = IndexPath(item: 0, section: section)
//
//            if let sectionAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
//                newLayoutAttributes.append(sectionAttributes)
//            }
//        }
//
//        return newLayoutAttributes
//    }
//
//    func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
//        // Helpers
//        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))
//
//        // Exit Early
//        guard let collectionView = collectionView else { return result }
//
//        // Fetch Number of Items for Section
//        let numberOfItems = collectionView.numberOfItems(inSection: section)
//
//        // Exit Early
//        guard numberOfItems > 0 else { return result }
//
//        if let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
//           let lastItem = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: section)) {
//            result.minimum = firstItem.frame.minY
//            result.maximum = lastItem.frame.maxY
//
//            // Take Header Size Into Account
//            result.minimum -= headerReferenceSize.height
//            result.maximum -= headerReferenceSize.height
//
//            // Take Section Inset Into Account
//            result.minimum -= sectionInset.top
//            result.maximum += (sectionInset.top + sectionInset.bottom)
//        }
//
//        return result
//    }
//
//    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else {
//            return nil
//        }
//
//        guard
//            let boundaries = boundaries(forSection: indexPath.section),
//            let collectionView = collectionView
//        else { return layoutAttributes}
//
//        let contentOffsetY = collectionView.contentOffset.y
//        var frameForSupplementaryView = layoutAttributes.frame
//
//        let minimum = boundaries.minimum - frameForSupplementaryView.height
//        let maximum = boundaries.maximum - frameForSupplementaryView.height
//
//        if contentOffsetY < minimum {
//            frameForSupplementaryView.origin.y = minimum
//        } else if contentOffsetY > maximum {
//            frameForSupplementaryView.origin.y = maximum
//        } else {
//            frameForSupplementaryView.origin.y = contentOffsetY
//        }
//
//        layoutAttributes.frame = frameForSupplementaryView
//
//        return layoutAttributes
//    }
//}
