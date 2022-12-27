//
//  Item.swift
//  
//
//  Created by Shunya Yamada on 2022/12/27.
//

import UIKit
import Shared

public extension SearchPlaceViewController {
    enum Item: DiffableDataSourceItem {
        case shortcut(ShortcutItemInput)
        case place(PlaceItemInput)
        case keyword(String)
        case seeMore

        public func cell(for collectionView: UICollectionView, at indexPath: IndexPath, with viewController: UIViewController?) -> UICollectionViewCell {
            switch self {
            case .shortcut(let input):
                let cell = collectionView.dequeueReusableCell(of: ShortcutCell.self, for: indexPath)
                cell.configure(with: input.iconName, title: input.title)
                return cell
            case .place(let input):
                let cell = collectionView.dequeueReusableCell(of: PlaceCell.self, for: indexPath)
                cell.configure(with: input.title,
                               kilometers: input.kilometers,
                               address: input.address)
                return cell
            case .keyword(let title):
                let cell = collectionView.dequeueReusableCell(of: KeywordCell.self, for: indexPath)
                cell.configure(with: title)
                return cell
            case .seeMore:
                let cell = collectionView.dequeueReusableCell(of: SeeMoreCell.self, for: indexPath)
                return cell
            }
        }

        public struct ShortcutItemInput: Hashable {
            let iconName: String
            let title: String
        }

        public struct PlaceItemInput: Hashable {
            let title: String
            let kilometers: String?
            let address: String?
        }
    }
}
