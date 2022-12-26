//
//  UICollectionView+.swift
//  
//
//  Created by Shunya Yamada on 2022/12/19.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(type, forCellWithReuseIdentifier: String(describing: type))
    }

    func register<T: UICollectionReusableView>(_ type: T.Type, for elementKind: String) {
        register(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: type))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(of type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(of type: T.Type, kind elementKind: String, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}
