//
//  GridLayout.swift
//  iPlanner
//
//  Created by Сергей Петров on 16.07.2021.
//

import UIKit

protocol GridLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, widthForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class GridLayout: UICollectionViewLayout {
    
    weak var delegate: GridLayoutDelegate?
    private let numberOfColumns = 3
    private let cellPadding: CGFloat = 6
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.height - (collectionView.contentInset.top + collectionView.contentInset.bottom)
    }
    private var contentWidth: CGFloat = 0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        
        let columnHeight = contentHeight / CGFloat(numberOfColumns)
        var xOffset = Array<CGFloat>(repeating: 0, count: numberOfColumns)
        var yOffset = Array<CGFloat>()
        
        for column in 0..<numberOfColumns {
            yOffset.append(CGFloat(column) * columnHeight)
        }
        
        var column = 0
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let cellWidth = delegate?.collectionView(collectionView, widthForPhotoAtIndexPath: indexPath) ?? 180
            let width = cellPadding * 2 + cellWidth
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: columnHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath) // создаем аттрибут
            attributes.frame = insetFrame // инициализируем frame у аттрибута
            cache.append(attributes) // добавляем аттрибут в кэш
            
            contentWidth = max(contentWidth, frame.maxX) // обновляем высоту коллекции
            xOffset[column] = xOffset[column] + width // обновляем ширину текущей рассчетной колонки
            
//            column = column < (numberOfColumns - 1) ? (column + 1) : 0 // переходим к следующей колонке
            column = (column + 1) % numberOfColumns
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleAttributes.append(attributes)
            }
        }
        return visibleAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
