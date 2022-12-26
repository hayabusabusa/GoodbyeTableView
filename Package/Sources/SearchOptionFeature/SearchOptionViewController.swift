//
//  SearchOptionViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/12/26.
//

import UIKit
import Shared

public final class SearchOptionViewController: UIViewController, DiffableDataSourceCollectionViewable {

    // MARK: - Subviews

    public lazy var collectionView: UICollectionView = {
        let collectionViewLayout = makeCollectionViewLayout()
        collectionViewLayout.register(SectionBackgroundView.self, forDecorationViewOfKind: "background")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SelectCell.self)
        collectionView.register(ToggleCell.self)
        collectionView.register(SectionBackgroundView.self, for: "background")
        return collectionView
    }()

    // MARK: - Properties

    public lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        makeDataSource()
    }()

    // MARK: - Lifecycle

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureCollectionView()
        configureDataSource()
    }
}

// MARK: - Configurations

private extension SearchOptionViewController {
    func configureSubviews() {
        view.backgroundColor = .systemBackground
    }

    func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.transport])
        snapshot.appendItems([
            .select(Item.SelectItemInput(title: "オプションA", isSelected: true)),
            .select(Item.SelectItemInput(title: "オプションB", isSelected: true)),
            .select(Item.SelectItemInput(title: "オプションC", isSelected: true)),
            .select(Item.SelectItemInput(title: "オプションD", isSelected: true)),
            .select(Item.SelectItemInput(title: "オプションE", isSelected: true))
        ], toSection: .transport)

        snapshot.appendSections([.fare])
        snapshot.appendItems([
            .toggle(Item.ToggleItemInput(title: "種別A", isOn: true)),
            .toggle(Item.ToggleItemInput(title: "種別B", isOn: false)),
            .toggle(Item.ToggleItemInput(title: "種別C", isOn: false))
        ], toSection: .fare)

        snapshot.appendSections([.seat])
        snapshot.appendItems([
            .toggle(Item.ToggleItemInput(title: "種別X", isOn: true)),
            .toggle(Item.ToggleItemInput(title: "種別Y", isOn: false))
        ])

        dataSource.apply(snapshot)
    }
}

// MARK: - CollectionView Delegate

extension SearchOptionViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let item = dataSource.snapshot().itemIdentifiers(inSection: section)[indexPath.row]

        var snapshot = dataSource.snapshot()

        switch item {
        case .select(let input):
            input.isSelected.toggle()
            snapshot.reloadItems([item])
        case .toggle:
            let items = snapshot.itemIdentifiers(inSection: section)
            items.forEach { fareItem in
                guard case .toggle(let input) = fareItem else { return }
                input.isOn = fareItem == item
            }
            snapshot.reloadItems(items)
        }

        dataSource.apply(snapshot)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

#if DEBUG
import SwiftUI

private extension SearchOptionViewController {
    struct Wrapped: UIViewControllerRepresentable {
        typealias UIViewControllerType = SearchOptionViewController

        func makeUIViewController(context: Context) -> SearchOptionViewController {
            let vc = SearchOptionViewController()
            return vc
        }

        func updateUIViewController(_ uiViewController: SearchOptionViewController, context: Context) {}
    }
}

struct SearchOptionViewController__Preview: PreviewProvider {
    static var previews: some View {
        SearchOptionViewController.Wrapped()
    }
}
#endif
