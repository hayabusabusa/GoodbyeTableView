//
//  DefaultSettingViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/12/19.
//

import UIKit
import Shared

/// iOS 標準の設定アプリのトップを再現した画面.
public final class DefaultSettingViewController: UIViewController, DiffableDataSourceCollectionViewable {

    // MARK: Subviews

    public lazy var collectionView: UICollectionView = {
        let collectionViewLayout = makeCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PlainCell.self)
        collectionView.register(ToggleCell.self)
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
        configureNavigation()
        configureCollectionView()
        configureDataSource()
    }
}

// MARK: - Configurations

private extension DefaultSettingViewController {
    func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.connection])
        snapshot.appendItems([
            .toggle(iconImage: UIImage(systemName: "airplane"),
                    iconBackgroundColor: .systemOrange,
                    title: "機内モード",
                    isOn: false),
            .plain(iconImage: UIImage(systemName: "wifi"),
                   iconBackgroundColor: .systemBlue,
                   title: "Wi-Fi"),
            .plain(iconImage: UIImage(systemName: "antenna.radiowaves.left.and.right"),
                   iconBackgroundColor: .systemGreen,
                   title: "モバイル通信"),
        ], toSection: .connection)
        snapshot.appendSections([.notification])
        snapshot.appendItems([
            .plain(iconImage: UIImage(systemName: "bell.badge.fill"),
                   iconBackgroundColor: .systemRed,
                   title: "通知"),
            .plain(iconImage: UIImage(systemName: "speaker.fill"),
                   iconBackgroundColor: .systemRed,
                   title: "サウンドと触覚"),
            .plain(iconImage: UIImage(systemName: "moon.fill"),
                   iconBackgroundColor: .systemIndigo,
                   title: "集中モード"),
            .plain(iconImage: UIImage(systemName: "hourglass"),
                   iconBackgroundColor: .systemIndigo,
                   title: "スクリーンタイム"),
        ], toSection: .notification)
        dataSource.apply(snapshot)
    }

    func configureNavigation() {
        navigationItem.title = "設定"
    }

    func configureSubviews() {
        view.backgroundColor = .systemBackground
    }
}

#if DEBUG
import SwiftUI

private extension DefaultSettingViewController {
    struct Wrapped: UIViewControllerRepresentable {
        typealias UIViewControllerType = DefaultSettingViewController

        func makeUIViewController(context: Context) -> DefaultSettingViewController {
            let viewController = DefaultSettingViewController()
            return viewController
        }

        func updateUIViewController(_ uiViewController: DefaultSettingViewController, context: Context) {}
    }
}

struct DefaultSettingViewController__Preview: PreviewProvider {
    static var previews: some View {
        DefaultSettingViewController.Wrapped()
    }
}
#endif
