//
//  NotesCollectionViewLayout.swift
//  iPlanner
//
//  Created by Сергей Петров on 09.07.2021.
//

import Foundation
import UIKit

protocol NotesCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, widthAtIndexPath indexPath: IndexPath) -> CGFloat
}

class NotesCollectioinViewLayout: UICollectionViewLayout {
    
    weak var delegate: NotesCollectionViewLayoutDelegate?
    
    private let numberOfColumns = 3
    private let cellPadding: CGFloat = 6
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth: CGFloat = 10
    
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 10
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        print(1)
        guard cache.isEmpty,
              let collectionView = collectionView
        else {
            return
        }
        print(2)
        
        let columnHeight = contentHeight / CGFloat(numberOfColumns)
        var yOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            yOffset.append(CGFloat(column) * columnHeight)
        }
        var column = 0
        var xOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            let cellContentWidth: CGFloat = delegate?.collectionView(collectionView, widthAtIndexPath: indexPath) ?? 180
            let width = cellPadding * 2 + cellContentWidth
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: columnHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            contentWidth = max(contentWidth, frame.maxY)
            xOffset[column] = xOffset[column] + width

            column = column < (numberOfColumns - 1) ? (column + 1) : 0

        }
        
//        let columnWidth = contentWidth / CGFloat(numberOfColumns)
//        var xOffset: [CGFloat] = []
//        for column in 0..<numberOfColumns {
//            xOffset.append(CGFloat(column) * columnWidth)
//        }
//        var column = 0
//        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
//
//        for item in 0..<collectionView.numberOfItems(inSection: 0) {
//            let indexPath = IndexPath(item: item, section: 0)
//            let cellContentHeight = delegate?.collectionView(collectionView, widthAtIndexPath: indexPath) ?? 180
//            let height = cellPadding * 2 + cellContentHeight
//            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
//            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
//
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//            attributes.frame = insetFrame
//            cache.append(attributes)
//
//            contentHeight = max(contentHeight, frame.maxY)
//            yOffset[column] = yOffset[column] + height
//
//            column = column < (numberOfColumns - 1) ? (column + 1) : 0
//        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
