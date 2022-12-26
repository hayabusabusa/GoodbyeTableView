//
//  Item.swift
//  
//
//  Created by Shunya Yamada on 2022/12/19.
//

import UIKit
import Shared

public extension DefaultSettingViewController {
    enum Item: DiffableDataSourceItem {
        case plain(iconImage: UIImage?, iconBackgroundColor: UIColor, title: String)
        case toggle(iconImage: UIImage?, iconBackgroundColor: UIColor, title: String, isOn: Bool)

        public func cell(for collectionView: UICollectionView, at indexPath: IndexPath, with viewController: UIViewController?) -> UICollectionViewCell {
            switch self {
            case let .plain(iconImage, iconBackgroundColor, title):
                let cell = collectionView.dequeueReusableCell(of: PlainCell.self, for: indexPath)
                cell.configure(with: iconImage, iconBackgroundColor: iconBackgroundColor, title: title)
                return cell
            case let .toggle(iconImage, iconBackgroundColor, title, isOn):
                let cell = collectionView.dequeueReusableCell(of: ToggleCell.self, for: indexPath)
                cell.configure(with: iconImage, iconBackgroundColor: iconBackgroundColor, title: title, isOn: isOn)
                return cell
            }
        }
    }
}

