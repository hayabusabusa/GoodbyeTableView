//
//  Section.swift
//  
//
//  Created by Shunya Yamada on 2022/12/27.
//

import UIKit
import Shared

public extension SearchPlaceViewController {
    enum Section: DiffableDataSourceSection {
        case shortcut
        case history

        public func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            switch self {
            case .shortcut:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(60), heightDimension: .absolute(56))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(60), heightDimension: .absolute(56))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12.0, bottom: 0, trailing: 12.0)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .history:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
    }
}
