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

    func dequeueReusableCell<T: UICollectionViewCell>(of type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}
