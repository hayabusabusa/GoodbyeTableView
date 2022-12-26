//
//  Item.swift
//  
//
//  Created by Shunya Yamada on 2022/12/26.
//

import UIKit
import Shared

public extension SearchOptionViewController {
    enum Item: DiffableDataSourceItem {
        case select(SelectItemInput)
        case toggle(ToggleItemInput)

        public func cell(for collectionView: UICollectionView, at indexPath: IndexPath, with viewController: UIViewController?) -> UICollectionViewCell {
            switch self {
            case .select(let input):
                let cell = collectionView.dequeueReusableCell(of: SelectCell.self, for: indexPath)
                cell.configure(with: input.title, isSelected: input.isSelected)
                return cell
            case .toggle(let input):
                let cell = collectionView.dequeueReusableCell(of: ToggleCell.self, for: indexPath)
                cell.configure(with: input.title, isOn: input.isOn)
                return cell
            }
        }

        public final class SelectItemInput: Hashable {
            let title: String
            var isSelected: Bool

            init(title: String, isSelected: Bool) {
                self.title = title
                self.isSelected = isSelected
            }

            public static func == (lhs: SearchOptionViewController.Item.SelectItemInput, rhs: SearchOptionViewController.Item.SelectItemInput) -> Bool {
                lhs.title == rhs.title
            }

            public func hash(into hasher: inout Hasher) {
                hasher.combine(title)
            }
        }

        public final class ToggleItemInput: Hashable {
            let title: String
            var isOn: Bool

            init(title: String, isOn: Bool) {
                self.title = title
                self.isOn = isOn
            }

            public static func == (lhs: SearchOptionViewController.Item.ToggleItemInput, rhs: SearchOptionViewController.Item.ToggleItemInput) -> Bool {
                lhs.title == rhs.title
            }

            public func hash(into hasher: inout Hasher) {
                hasher.combine(title)
            }
        }
    }
}
