//
//  DiffableDataSourceCollectionViewable.swift
//  
//
//  Created by Shunya Yamada on 2022/12/19.
//

import UIKit

/// Diffable DataSource の Section として利用する型に適合させる Protocol.
public protocol DiffableDataSourceSection: Hashable {
    /// Compositional Layouts を作成する.
    /// - Parameter environment: Layout の状態など.
    /// - Returns: Section に対応したレイアウト.
    func layout(for environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}

/// Diffable DataSource の Item として利用する型に適合させる Protocol.
public protocol DiffableDataSourceItem: Hashable {
    /// CollectionView の Cell を作成する.
    /// - Parameters:
    ///   - collectionView: Cell を表示する CollectionView.
    ///   - indexPath: Cell の IndexPath.
    ///   - viewController: Cell から Delegate を設定する場合に利用する ViewController.
    /// - Returns: Item に対応した Cell.
    func cell(for collectionView: UICollectionView, at indexPath: IndexPath, with viewController: UIViewController?) -> UICollectionViewCell
}

/// Diffable DataSource と Compositional Layouts を利用した画面に適応させる Protocol.
public protocol DiffableDataSourceCollectionViewable: AnyObject {
    /// Diffable DataSource で必要になる Section の型.
    associatedtype Section: DiffableDataSourceSection
    /// Diffable DataSource で必要になる Item の型.
    associatedtype Item: DiffableDataSourceItem

    /// サブビューとして追加する CollectionView.
    var collectionView: UICollectionView { get }
    /// CollectionView が DataSource として参照する Diffable DataSource.
    var dataSource: UICollectionViewDiffableDataSource<Section, Item> { get }
}

public extension DiffableDataSourceCollectionViewable where Self: UIViewController {
    /// CollectionView のセットアップを行う.
    func configureCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    /// CollectionView のレイアウトを Section 単位で作成する.
    func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, environment in
            guard let self = self else { return nil }
            return self.dataSource.snapshot().sectionIdentifiers[section].layout(for: environment)
        }
    }

    /// CollectionView の DataSource を作成する.
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            itemIdentifier.cell(for: collectionView, at: indexPath, with: self)
        }
    }
}
