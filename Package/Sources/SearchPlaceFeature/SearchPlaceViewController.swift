//
//  SearchPlaceViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/12/27.
//

import UIKit
import Shared

public final class SearchPlaceViewController: UIViewController, DiffableDataSourceCollectionViewable {

    // MARK: Subviews

    public lazy var collectionView: UICollectionView = {
        let collectionViewLayout = makeCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeywordCell.self)
        collectionView.register(PlaceCell.self)
        collectionView.register(SeeMoreCell.self)
        collectionView.register(ShortcutCell.self)
        return collectionView
    }()

    // MARK: Properties

    public lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        makeDataSource()
    }()

    // MARK: Lifecycle

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

private extension SearchPlaceViewController {
    func configureSubviews() {
        view.backgroundColor = .systemBackground
    }

    func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

        snapshot.appendSections([.shortcut])
        snapshot.appendItems([
            .shortcut(Item.ShortcutItemInput(iconName: "mappin.circle", title: "住所")),
            .shortcut(Item.ShortcutItemInput(iconName: "tag", title: "ジャンル")),
            .shortcut(Item.ShortcutItemInput(iconName: "house", title: "自宅")),
            .shortcut(Item.ShortcutItemInput(iconName: "building", title: "職場")),
            .shortcut(Item.ShortcutItemInput(iconName: "star", title: "登録")),
            .shortcut(Item.ShortcutItemInput(iconName: "mappin.and.ellipse", title: "マイルート")),

        ], toSection: .shortcut)

        snapshot.appendSections([.history])
        snapshot.appendItems([
            .keyword("西友 御器所店"),
            .place(Item.PlaceItemInput(title: "マツモトキヨシ 御器所店",
                                       kilometers: "1.1km",
                                       address: "愛知県名古屋市昭和区御器所通3-12-1")),
            .keyword("ラーメン"),
            .place(Item.PlaceItemInput(title: "渋谷駅",
                                       kilometers: "238km",
                                       address: "東京都渋谷区道玄坂１丁目1-1")),
            .place(Item.PlaceItemInput(title: "ねこの博物館",
                                       kilometers: "199km",
                                       address: "静岡県伊藤市八幡野1759-242")),
            .place(Item.PlaceItemInput(title: "伊豆シャボテン動物公園",
                                       kilometers: "198km",
                                       address: "静岡県伊藤市富戸1317-13")),
            .keyword("川名公園"),
            .place(Item.PlaceItemInput(title: "成城石井 石川橋店",
                                       kilometers: "820m",
                                       address: "愛知県名古屋市瑞穂区上山町2-18-1")),
            .keyword("名古屋駅"),
            .keyword("川名"),
            .place(Item.PlaceItemInput(title: "らぁめん 翠蓮",
                                       kilometers: "580m",
                                       address: "愛知県名古屋市昭和区花見通3-11")),
            .seeMore,
        ], toSection: .history)

        dataSource.apply(snapshot)
    }
}

// MARK: - CollectionView Delegate

extension SearchPlaceViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

#if DEBUG
import SwiftUI

private extension SearchPlaceViewController {
    struct Wrapped: UIViewControllerRepresentable {
        typealias UIViewControllerType = SearchPlaceViewController

        func makeUIViewController(context: Context) -> SearchPlaceViewController {
            let vc = SearchPlaceViewController()
            return vc
        }

        func updateUIViewController(_ uiViewController: SearchPlaceViewController, context: Context) {}
    }
}

struct SearchPlaceViewController__Preview: PreviewProvider {
    static var previews: some View {
        SearchPlaceViewController.Wrapped()
    }
}
#endif
