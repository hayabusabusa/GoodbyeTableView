//
//  ShortcutCell.swift
//  
//
//  Created by Shunya Yamada on 2022/12/27.
//

import UIKit

final class ShortcutCell: UICollectionViewCell {

    private let iconSize: CGFloat = 32

    // MARK: Subviews

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = iconSize / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with iconName: String, title: String) {
        iconImageView.image = UIImage(systemName: iconName)
        titleLabel.text = title
    }
}

private extension ShortcutCell {
    func configure() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.3)

        configureSubviews()
    }

    func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(iconBackgroundView)
        contentStackView.addArrangedSubview(titleLabel)

        iconBackgroundView.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: iconSize),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: iconSize),
            iconImageView.topAnchor.constraint(equalTo: iconBackgroundView.topAnchor, constant: 6),
            iconImageView.trailingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: -6),
            iconImageView.bottomAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor, constant: -6),
            iconImageView.leadingAnchor.constraint(equalTo: iconBackgroundView.leadingAnchor, constant: 6),
        ])
    }
}

#if DEBUG
import SwiftUI

private extension ShortcutCell {
    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = ShortcutCell

        func makeUIView(context: Context) -> ShortcutCell {
            let cell = ShortcutCell()
            cell.configure(with: "house", title: "自宅")
            return cell
        }

        func updateUIView(_ uiView: ShortcutCell, context: Context) {}
    }
}

struct ShortcutCell__Preview: PreviewProvider {
    static var previews: some View {
        ShortcutCell.Wrapped()
            .previewLayout(.fixed(width: 60, height: 56))
    }
}
#endif
