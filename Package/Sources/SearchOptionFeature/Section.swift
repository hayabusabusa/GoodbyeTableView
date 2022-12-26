//
//  Section.swift
//  
//
//  Created by Shunya Yamada on 2022/12/26.
//

import UIKit
import Shared

public extension SearchOptionViewController {
    enum Section: DiffableDataSourceSection {
        case transport
        case fare
        case seat
        case walkingSpeed

        public func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
            section.decorationItems = [.background(elementKind: "background")]
            return section
        }
    }
}
