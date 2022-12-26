//
//  Section.swift
//  
//
//  Created by Shunya Yamada on 2022/12/19.
//

import UIKit
import Shared

public extension DefaultSettingViewController {
    enum Section: DiffableDataSourceSection {
        case connection
        case notification
        case utility

        public func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
        }
    }
}
